Return-Path: <linux-spi+bounces-7710-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90792A95FCB
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 09:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB682169AC4
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 07:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4F1CAA79;
	Tue, 22 Apr 2025 07:46:43 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9072B15B115;
	Tue, 22 Apr 2025 07:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308003; cv=none; b=RpsQZokRsGcJlLCUUbT5j7O38cBPCLTYxNnEbBhoRcaxtwhLyxs4xv0MieBgJS0+B5YObQVcNpOtFRnwz0WjoXRLD/bPl0eEMZ8lLhOQ1bRyWlFbJTwzWBHZex/hb7vbhdy/ZR5ARWSNRvqOIAJIoljvey8mPNNthIitAhwioNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308003; c=relaxed/simple;
	bh=zMQCHFevzijF0AxHhH+gusR4CT8pHCOpcLy7M10lK5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjeTTmPbSwHauLzI8v5L7BtqZ9q0E/XR36KN4RmUdQ2HlTcXeugOVxHTvRqlX2/AYTAWd/dyspOZpeJ8TQkVY99PTC6iGWSTRESjMx0kYqdbbjnHzElN0R5gcYzqhoxgGgxPD+zb0sf01FDWvGegKLqSMQugZ7Jj7nqSpmZYLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86d2fba8647so4002438241.0;
        Tue, 22 Apr 2025 00:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745307998; x=1745912798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oSFRSq2pGngywe5PAtRGvPoQXPxTMBPmVFi4/RAkfR4=;
        b=Z3g1/2OCrRbldlb2I4uRcYP5RZ44z7rN+L6m6su7h5eatJkuz0+44CV+tiGCsQ28pU
         /riuCXnwpZoVR0C9kuOi5/Mg57FZVFvjc6Bf1ax6Tc4MRI+mLNVLPgVDqNRACsUpfTvx
         BH39E+zMtBXa+Cnc3K9kfl0VCkK+z5uAhiYB8on6znLb3Dz4UGswfnyp3kfITRBM1upq
         4h2HvzSqSLplfNzyacvZn7REd1MxeKrarK2N+VNd8AN9r8qdUxxD8hdl6lWl4fZcqfHa
         QvfWUKt+5A4XRyQHw9KWZBD7355nd2znzRS4w3h4ezrqvkjdtmQ7amqOfU3wj6lRzQIq
         8QVA==
X-Forwarded-Encrypted: i=1; AJvYcCV1NIbRafvTsmHkW37j+TN5cMCZkl88t/N9aS/gsh7UCTBH6RzVbEMeJL8rZgUwhMuWtf9iVkYFImSC@vger.kernel.org, AJvYcCVtoeXbaOXQ2zKMs7gtnOI6Ar1PI3DTJy9Pxhxk4pDb3+SvxZ337AoPmdiEQT9LfAW7Lym61cJrnOskf+7mIMyLQJQ=@vger.kernel.org, AJvYcCWHI1tw4qU44mir2/lXAXwyAM2gfzA2Zf6ZkIO/H726D8x0R3NPpqpv4ZZyFXr5FEPFYxSMY5lVmLvv@vger.kernel.org, AJvYcCX2a4k+sWO6K42r8J+DvKPIGbOwDwIB0QgddiiLnLhalpcF/AF3XCwbY1zVnJlWkSDj7XacyPFtVU++vmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRELMq2xmSYAa7zNdyVWCHWlBblD3fCmO7Ovm6o0ZZsqhnVVq6
	Hai5mfmMFsrefJeyTjctLhdEIgy+OoVhkIyOPfQMfUXe5U+AHUI/c+4lS033
X-Gm-Gg: ASbGnctzLU2N9CF+UW7Ojg4h+iiBW7a7vu2mzc+KKobHTVzXRIwITrU2qITlvSwPkre
	aaHpBXUEE5iWvGnZ+VDJPRb2PyPLs8jaYWB1vD1kA2ec4j0k79wwCUGDEUX+p3aSYsNu4hx1tkp
	sCBSpkOOWIqgQNYkSPjCjYey0R/atg5dkt9/K8Og1YSTy+bn30UfeKIIlitnyYXVqCBxFMYKcic
	iSC63L6ICR+r/wqGA+I4V/FNtGCs9ypuYdjnVS5t+DZIwXKcbIcQrGvqkqcF8pE6X8CMjBgFnlq
	HlVutl9WL9a2W7NI4COWbgx2CHboSex+/QG7Dr0KCZ6j1+gZMAvtD+2f2cyk+1frWs2b5wbEsEA
	x3SXGPF0=
X-Google-Smtp-Source: AGHT+IHM+gzmYnsjJsgEWvUwCgPk2WJMeHHKA51LqEK3DaMENbiFPYx7zC92RGgfQZmahkkbEMtgqw==
X-Received: by 2002:a05:6102:21a9:b0:4bb:e36f:6a35 with SMTP id ada2fe7eead31-4cb80132831mr8320319137.14.1745307998165;
        Tue, 22 Apr 2025 00:46:38 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7ddb214esm2106172137.8.2025.04.22.00.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 00:46:37 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso4553687e0c.3;
        Tue, 22 Apr 2025 00:46:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3sIIPjj+gX1ulVD5cMSataBGb+bMgINxznCGsJ7MIMV/hlSH0aT3jwnlOJCHrtoohJ1M58Sj7jt6DvefOn2Oo5Zw=@vger.kernel.org, AJvYcCU7pR2yW/6OXWVkog4WvOFbZR8dZx8ugWFJE7rx63r4sLOeRRJnQt7GhiITFj39Zr9QpUl/KqIDCArBkfA=@vger.kernel.org, AJvYcCWejdTfn5Q7pdFIyUgjBNtRjwSWou2VTgUdNWSJh8cnpPzwoRy6w3oUNvREHKYcV7z8FvKuDt4cSc3k@vger.kernel.org, AJvYcCXC/C3BZKnyh1ErW72+MvxUZ83Y4SseNXKNr0qK4orb6gJQyagyacFPll/fGgMUytfmzDwpkP6Li7rx@vger.kernel.org
X-Received: by 2002:a05:6122:885:b0:523:7c70:bc9c with SMTP id
 71dfb90a1353d-5292541d3demr10328462e0c.5.1745307997189; Tue, 22 Apr 2025
 00:46:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
 <87y0w21a4h.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdXwJGj-xTqEgtsNNX2UR4kPnJ5m2H+KbULdjX7dmUoW8A@mail.gmail.com>
 <87msch81yh.wl-kuninori.morimoto.gx@renesas.com> <87plhb4qbb.wl-kuninori.morimoto.gx@renesas.com>
 <CAMuHMdUKBdTyA0fnfpQT6iad3S7+z3dJkh4UnS14miqgFcUhuA@mail.gmail.com> <875xj24dzq.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <875xj24dzq.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Apr 2025 09:46:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHEiik6aO84OxY8=9=ZUh7uanQL6nY-r+Fp2qo2Z6CXg@mail.gmail.com>
X-Gm-Features: ATxdqUGZ3Mch_gBjSIlT_XBINsA8ob6lZOupoAgYV8_Pr8U469hqQQi0vIOzvcU
Message-ID: <CAMuHMdUHEiik6aO84OxY8=9=ZUh7uanQL6nY-r+Fp2qo2Z6CXg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S
 Sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Fri, 18 Apr 2025 at 00:31, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > >         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #address-cells for SPI bus
> > >           also defined at [Board file]
> > >         [SoC file]: Warning (spi_bus_bridge): /soc/spi@xxxx: incorrect #size-cells for SPI bus
> > >           also defined at [Board file]
> > >
> > > MSIOF dt-bindings doesn't load spi-controller.yaml, but why I got "spi_bus_bridge"
> > > warning ?? I wonder dt compiler (?) automatically check "spi" node ?
> > > I have tryed some code, my expectation seems correct (In case of node name was "spi@xxx",
> > > I got many SPI related warnings even though I didn't load spi-controller).
> >
> > These come from dtc, which makes its own assumptions:
> >
> >     $ git grep spi_bus_bridge
> >     scripts/dtc/checks.c:static void check_spi_bus_bridge(struct check
> > *c, struct dt_info *dti, struct node *node)
> >     scripts/dtc/checks.c:WARNING(spi_bus_bridge, check_spi_bus_bridge,
> > NULL, &addr_size_cells);
> >     scripts/dtc/checks.c:WARNING(spi_bus_reg, check_spi_bus_reg, NULL,
> > &reg_format, &spi_bus_bridge);
> >     scripts/dtc/checks.c:   &spi_bus_bridge,
> >
> > Perhaps we do need to extend the use of role-specifying properties
> > like "interrupt-controller" (in Device Tree Specification v0.4 and in
> > dt-schema) and the few others in Documentation/devicetree/bindings:
> >
> >     gpio-controller
> >     mctp-controller
> >     msi-controller
> >     system-power-controller
>
> Hmm... but I'm not familiar with DT. Should I do it ??

I do not think you should do that.
This is something to be decided by the DT and SPI maintainers.

> Except from SPI warning, and focus to MSIOF-I2S, my patch itself is
> not so bad, right ?
> I will post v4 patch-set, with comment above.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

