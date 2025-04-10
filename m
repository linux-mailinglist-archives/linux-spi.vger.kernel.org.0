Return-Path: <linux-spi+bounces-7513-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAE8A83BAE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF468A150F
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 07:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17891D2F53;
	Thu, 10 Apr 2025 07:47:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FC6130A54;
	Thu, 10 Apr 2025 07:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744271279; cv=none; b=pxMvsPAUZlyHtUz823gznmQKF0Dy0YdgHlnK1I/7Km4dsLRWPpIZ+ANhyTzv9ObEKI8Y5nRXB0qcIAlhIX1ANMBQkPkZDyayB50o0cereFaZDccOrvIVTE92v+h0/VQalLUVcP308iuIqiziZCMjUTMv/uw8e9ZadcSH1Td8Y2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744271279; c=relaxed/simple;
	bh=RoRER4+1aEdpOme56/aP1R/kwbFrrc4I8Nn6Jg8C1ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXRe7a1O/0jp24dZTH70QZdQRmlvnk/zbUDFSCpHAoSi0m6xbpkid2kYU3DCepRF4UZRajwSf6Z3msCMLhfzM5LBwpaoyDq/4HhRognadoKJVVMXsJsmTDL6G+rlLPE5k5JE0X7IvDLEgnCGqHFZ6rUEESyYEsj73Gu+Z0PFsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so460038241.3;
        Thu, 10 Apr 2025 00:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744271276; x=1744876076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYlM/NWonpmxHHJcBtv1TyUMxukkVC17bMxK3+UA8ZU=;
        b=s1UAkivChL4T4cUYx+I2YsPT1upXBoTPjMRLBG7r6EHYcW9JQ1T8BHI5WmPKliNtCt
         ufynrQM+vLxM67mnJuSyjOGpUKsS1T+m6XPXKNCo7U/nMq+p9bkCoEz/CcEHW2mdb/oF
         ksSaoLl8mrY0UM4SYVLavyn1whdjpkxWhl269477GSRqJPKwR9vuATnSD5IUi2VhSP7+
         dptLfuIVYHvfSY9P8Nr1BE7+qQHxAZmScvYozXxRSyGliwl/OTpWJ/QBubvlUxK4x32T
         7G8KVSlOijPUANbiwzLJE2zcrwW3SXYKC+YIxU8fQQD/9rAf/2j7mNRP7g1Dt1pPJxTW
         FhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV28S0PTyxVGoan19ZxGS5ACrbSqrkqnIMGxCzWuOEJfTNgx4S8Z8LCs9jTXLl8UCZH+1QD1JXQ92XOwpzG0dcq/vw=@vger.kernel.org, AJvYcCV7DZ1NYbPNRamOgxgfjDxvRmxayvEHajd4inPkPq7aGQU99iYi37ob6hYP7Q6V41UgP68z69f8NXaW@vger.kernel.org, AJvYcCVjbMCIivYw5rgBmDyTGwiDFiyT/EgUxGav3bYB+bInQHxLV1TG4kQxgGFb+7f3J6ImKytSGuzIDZ5A@vger.kernel.org, AJvYcCX0hSjJlEuP+QsRnTeaZI8Mlfo+R9JfulaVUYXysSZqOxE1ySJmf+gIIE2Rt3MAxbve7orN+FDmSA+iUho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIaJJUGpUJo2A9+EDRWYq4Xmp9NNFy6/E88CsUuV74DlMEPh1U
	QzLmx/3bmZk07anqVXAoATdeevaDe6y4ZsivDu7zJmayfut95Zpij2Lna+tQJXk=
X-Gm-Gg: ASbGnctijNc+xM5R0H27eaLK1u//RdK6LgI/FLM18i8GoX/IuCOoloUqFjE2o31EtIk
	zYxuRUq0Dcf9Myn3jXwrKI/OGRR1PzVl/XNB5Hf8HkeDmYRPjoxmqN3P54+ANqUD4iIHbSefSwS
	AH1y+Y1R7WuyRorpmWzg0CiBB9giHcRf3rcE0ZDPX2HumLwr4nUZKuan1J4DnIcwTOCTekfofva
	yNMJR923PxgG8TG81dXe8hf8ocod41IjycvnSwY8wTDVp0GQVDubzsFhQD9aMbdiMC/zDsTHrlE
	3mlsmR6PSB9z7LQWlKNgxvsLRqd+PpVS7KKQlpo4b5gpRTfIDXxOXHrFdnjXhnTfNrvcYlA67U9
	mnPE=
X-Google-Smtp-Source: AGHT+IFWtghlh+ER1WsXyvSCmrqME5dCdsLfms8hbIgVkpugq65/Biw+fMQynCL88Q8G9pOF+qeelQ==
X-Received: by 2002:a05:6102:3f48:b0:4c1:b2c2:61a with SMTP id ada2fe7eead31-4c9d362a2f9mr1257188137.25.1744271275900;
        Thu, 10 Apr 2025 00:47:55 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c98ee518sm500928137.28.2025.04.10.00.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 00:47:55 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so460025241.3;
        Thu, 10 Apr 2025 00:47:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+aHCBr95T2EjIZuuIp1o5b4tLwvnX/DUn/7TH+uwSGfmIfIXhIBRNNlLHryaATsZFgfdpiilhTEOGsNHDVnrucPE=@vger.kernel.org, AJvYcCVLJ6Wj2QFhY9JbXYHBKTYXmFypZfnGBltub5i44t5Ll2eNseBEywL+H9Fpoy47XgaH+E3ROl+CsgHo@vger.kernel.org, AJvYcCW+k+Z0qg1tnmyiem9XOHWCo0YxG/wmQhcppuJkkz3rHfq3ROnVR5l6FyZho6l9/98QEu+2CPhGpZHO@vger.kernel.org, AJvYcCWE8k96qFW4C9zeIeJgDbO2vWEngLbFbjbQWr2WjruGjW3nKXG/UC2PFwWgYMl0Ol1lyv1l73v8Yns4cm8=@vger.kernel.org
X-Received: by 2002:a05:6102:1515:b0:4bb:de88:d027 with SMTP id
 ada2fe7eead31-4c9d34af187mr1482504137.7.1744271275576; Thu, 10 Apr 2025
 00:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <875xjeb0wu.wl-kuninori.morimoto.gx@renesas.com>
 <87wmbu9may.wl-kuninori.morimoto.gx@renesas.com> <CAMuHMdWL_C-Vg3d+fAK_nXvzeZNNPDkkzPjB1oHRKHh16rZUHw@mail.gmail.com>
 <8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8734egnbl0.wl-kuninori.morimoto.gx@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Apr 2025 09:47:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV3Wm=aES=WZtYNGQrA1W3OFGrrOR=Nwb2FXACeVmPzAg@mail.gmail.com>
X-Gm-Features: ATxdqUHt59yuP5KWiSc_poBM0f4cr5ZmpOk68rO_kue5X07KSV3L3oZ8ztd4RY0
Message-ID: <CAMuHMdV3Wm=aES=WZtYNGQrA1W3OFGrrOR=Nwb2FXACeVmPzAg@mail.gmail.com>
Subject: Re: [PATCH 6/7] ASoC: renesas: add MSIOF sound support
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Morimoto-san,

On Thu, 10 Apr 2025 at 01:45, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> > > +       /* SITMDRx */
> > > +       if (is_play) {
> > > +               val = PCON | SYNCMD_LR | SYNCAC | TXSTP;
> > > +               if (msiof_flag_has(priv, MSIOF_FLAGS_NEED_DELAY))
> > > +                       val |= DTDL_1;
> > > +
> > > +               msiof_write(priv, SITMDR1, val);
> > > +
> > > +               val = BITLEN1(width);
> > > +               msiof_write(priv, SITMDR2, val | GRP);
> > > +               msiof_write(priv, SITMDR3, val);
> > > +
> >
> > Don't you have to initialize SITMDR[123] unconditionally, as reception
> > requires transmitting dummy data on R-Car (cfr. SPI_CONTROLLER_MUST_TX)?
>
> Good catch, but I added 1 restriction for MSIOF-I2S mode.
> I have explained it on top of this driver. The restriction is
> "MSIOF-I2S doesn't work as Clock/Frame Provider Mode".
> So, dummy transmit for RX is not needed/assumed.
> I think it is one of big-diff between MSIOF-SPI ?

IC.  Being just a mortal sound-noob, I didn't know what "Clock/Frame
Provider Mode" means ;-) Oh, now I understand. I had missed
completely that you are running MSIOF in slave mode. So everything
should be fine.

And

    /* SITSCR */
    #define SITSCR_V(p, d) ((p << 8) + d)

is unused, and can be removed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

