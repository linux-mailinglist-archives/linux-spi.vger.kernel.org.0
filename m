Return-Path: <linux-spi+bounces-11648-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25059C9271F
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1D2834591D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BA923D2B4;
	Fri, 28 Nov 2025 15:22:41 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C90A221F12
	for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 15:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764343360; cv=none; b=DemZ3cwjPoyUxsnvg/VDZ4NN7gyZUu8WRit1H+d25lcxsAjvbO09X8M5NocR5qFiyPm35QAg55TeVAaGYeV9oMF7uA9+sWZcJauRQLK6ZW/ddV3smibDdE7rCrHBiTO57MDD6XSCYRQENpOFZZe/gedZQJmUewxy1owr19ghu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764343360; c=relaxed/simple;
	bh=WySJ5tDr4GaYr5lUCdun1Iq88/ZJieVg0Ls3zRbLsgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boKb49fwl7qzORdjfCD2uVfyCgx6TFobGJVGrVoHVaPhkOfixO/mjpEYIg8Xegm+tETn9QUNftD/3zDiUfP4rvCDRyHmBRT+fQgp3dyG96qI0xQVDgoqHm/uIVw//Dgf9LSp1gAdKi+sOEvKS55B/94mz5oIDyjZk5ynF70Rnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-9351ed45fb8so488523241.0
        for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 07:22:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764343358; x=1764948158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSU3eijvpTpAPGY7FhsdCeUuSldlsRzVmB+sdM/jI28=;
        b=lKdLyKVqOOuLTcqF1Nw1wfkT4TUbPa0UD+Ngq5TUeHmZF/q70s+IlDxYTIsiGB2pKK
         kHDUPhdcBnXcC2bl98g+mNjSO2Fn3bTA4PS6P0FkQMJnnjFIId+NOJiaVTgfwf/BE/kF
         0WQJuCQFnPi7W1AMSotigLgmRa7LSm4edi+ybl1giICJBPrJE9ogYIK+Oc+NvZi8l/Zg
         hHpm7862U0+pwIlXqGLE0qwlxgmjRSBTMeZ3584Ce2ue5BcfGAGoMdBfOTelC4trlpBS
         bPaE+if7Xx6pCM5r1GMv+U4uFl/ntcO+gOgB9MJB+oe31F271RXZOV0YdRwW1eaCG2ZD
         Npaw==
X-Forwarded-Encrypted: i=1; AJvYcCV5bWMpZ6i+2TUZRcd3PgjWfUrBHTQqDb4Z05zzGnszyBkBZaLNOlY597yndF3qs2m/1DsryMVAXmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkKPexnVAYRoVAFHr03p62uiPQ6Q/K8yQ9DUJvHxapCvTUqzGE
	jHQ6iy4WAmoOqXCPpiZpzyeD/jCk9zbY5DPYgNLh1lF3cDp9AOrXpJ7U+1PEeu+W
X-Gm-Gg: ASbGnctKd84VoTH7+bumFbFM07FdROTqDw3rM1QlilIlfm0METoeB/4LdapqIoIqyIo
	ljXzHut9H+ROxK3mmCPT+8lh+GA9S0hG+HEFZez+VnW84zQyLMMsjBcDr6dsZB/OmaH8MMQo8Gx
	D25zsA5V/K6SJ+QxNAhjier7lrrPUyIKRglL0GKeaZ5Hp1VTXeBwPqFVdI/djK50zsz+JUMShaH
	WnsEumSNweO3dHdKL1qWkToWjO7eBNrAfFETSw6i1RsHfPx64r4N2VZE8KS6ao5b2mWvSMCbqNj
	cHnriS78k7joRCvekRcIKSg/OsYQlAEm/zdtYHbhZ8CAf7Ie7+6uKYVtJF9J0kDVQxaS8mDd8zm
	qulmpwOedCwEMpc2RcROWEuab7Xg+XmYSpg0hsnEBYJNTF0iYPpc9D9/EmUDDwdhgsVCH9n2j2f
	N4j4j2HB5Y/XsKasmB/rTMoyiND+ZWek8t9iijZ1/Z1ETttIAZzzcyfRpE3wQ=
X-Google-Smtp-Source: AGHT+IFRUbIfHppj7rSSWF6ilS3RL219pgk1aeT9dWfcXwRWJpN5YP1W0r4OCYvS6UI/mQUe87oFCw==
X-Received: by 2002:a05:6102:3049:b0:5dd:b2a0:ac69 with SMTP id ada2fe7eead31-5e22422da70mr5303803137.5.1764343358093;
        Fri, 28 Nov 2025 07:22:38 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd75f2eb4sm2199657241.10.2025.11.28.07.22.34
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 07:22:36 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dfb5fcf063so544514137.1
        for <linux-spi@vger.kernel.org>; Fri, 28 Nov 2025 07:22:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZVeJIlD7y+7ssR8YeX65n8IiQZXaDigg5a+Fk6ByHivf3rzuyd4sOwziHavjePV4YTYNh4MD3xmk=@vger.kernel.org
X-Received: by 2002:a05:6102:3e96:b0:5df:b3ed:2c8b with SMTP id
 ada2fe7eead31-5e22442a01cmr5399952137.38.1764343353749; Fri, 28 Nov 2025
 07:22:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119161434.595677-1-cosmin-gabriel.tanislav.xa@renesas.com> <20251119161434.595677-13-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251119161434.595677-13-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Nov 2025 16:22:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVt54J8n52QhLGC+k2FcVV=Eg57YCSgwb2imzTFkVkYQA@mail.gmail.com>
X-Gm-Features: AWmQ_bmvHPlzOAiPwp3vhsRbnO5GK1W4yQEIPYWe8DSxgLcQBpsrkHr2BizGasY
Message-ID: <CAMuHMdVt54J8n52QhLGC+k2FcVV=Eg57YCSgwb2imzTFkVkYQA@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] arm64: dts: renesas: r9a09g077: Add SPIs support
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Nov 2025 at 17:16, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Add support for the four SPI peripherals on the Renesas RZ/T2H Soc.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

