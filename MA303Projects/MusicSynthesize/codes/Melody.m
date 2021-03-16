function MelodPart=Melody()
[F,h,fd,f,ed,e,s,~,~,fdblk,fblk,edblk,eblk,sblk]=Tone(@GuitarMe,3,7); % use guitar, tones are in [C3,C6)
F=@(n) F(n+7);
h=@(n) h(n+7);
fd=@(n) fd(n+7);
f=@(n) f(n+7);
ed=@(n) ed(n+7);
e=@(n) e(n+7);
s=@(n) s(n+7);
%% First Paragraph
p1=[e(7),s(5),e(7),e(7),e(8),e(5),f(8),sblk,...% sec
    e(6),s(6),e(6),e(7),h(7),sblk,...% sec
    e(7),s(5),e(7),e(7),e(8),e(5),f(8),sblk,...% sec
    e(6),s(6),e(6),e(7),h(7),sblk,...% sec
    ];
%% Paragraph 2
p2=[edblk,s(5),repmat(s(9),1,4),s(9),e(8),s(7),s(7),e(8),ed(7),...% sec
    e(5),s(5),e(6),h(7),sblk,...% sec
    edblk,s(5),repmat(s(9),1,4),s(9),e(8),s(7),s(7),e(8),ed(7),...% sec
    e(5),s(5),e(6),h(5),sblk,...% sec
    edblk,s(5),repmat(s(9),1,4),s(9),e(8),s(7),s(7),e(8),ed(7),...% sec
    e(5),s(5),e(6),h(7),sblk,...% sec
    edblk,s(5),repmat(s(9),1,4),s(9),e(8),s(7),s(7),e(8),ed(7),...% sec
    e(5),s(5),e(6),h(5),sblk,...% sec
    ];
%% Paragraph 3
p3=[fblk,f(10),ed(10),ed(11),e(12),...%sec
    ed(11),ed(9),ed(9),sblk,e(9),e(8),e(7),...%sec
    fd(8),eblk,ed(8),ed(9),e(10),...%sec
    F(9),...%sec
    ];
%% Paragraph 4
p4=[...
  fblk,f(10),ed(10),ed(11),e(12),...%sec
  ed(11),s(14),sblk,s(13),sblk,fd(12),s(12),s(13),s(14),...%sec
  s(14),s(15),s(14),fd(12),sblk,fdblk...%sec
  f(11),f(12),f(13),e(12),e(13),...%sec
];
%% Paragraph Main1
p5=[...
    repmat(e(14),1,3),s(16),e(14),e(13),e(13),s(11),s(11),s(12),...%sec
    repmat(e(13),1,3),s(14),e(13),e(12),f(12),sblk,...%sec
    s(12),s(10),s(11),e(12),e(12),e(11),e(11),e(13),e(11),s(10),...%sec
    e(10),s(9),e(9),e(13),sblk,s(12),e(13),f(14),sblk,...%sec
];
%% Paragraph Main2
p6=[...
    repmat(e(14),1,3),s(16),e(14),e(13),e(13),s(11),s(11),s(12),...%sec
    repmat(e(13),1,3),s(14),e(13),e(12),f(12),sblk,...%sec
    s(12),s(10),s(11),e(12),e(12),h(11),sblk,...%sec
    f(9),f(10),h(11),...%sec
];
%% return
MelodPart=[
    1/4.*p1,...
    p2,...
    p3,...
    p4,...
    p5,...
    p6,...
];
end