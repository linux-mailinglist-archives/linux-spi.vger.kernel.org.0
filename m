Return-Path: <linux-spi+bounces-1496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6958667B2
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 03:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C30B21365
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D768E3233;
	Mon, 26 Feb 2024 02:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyeGO81K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36202E55F
	for <linux-spi@vger.kernel.org>; Mon, 26 Feb 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912986; cv=none; b=LHWmH/HFI1sTTLkbDT5xOnbLjoTNPm0ixWaqnKuU4h7rJUkuoaVHHEmM9Xhu/x65JJfEHeNdhIdG+nRRAnWPIgWz83yxky3VbtGcUBwH2xYHloSOo0EHaFh/RVOgVquaeK3hivxdmDhK7SRah9POCgcPYgdeFIHTSUMrKB5E8IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912986; c=relaxed/simple;
	bh=O4cpaHBEdPSwYMPzpDqnA+dJ66X3qsQRUCH+N+Yn5wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glYhQlAY7igChAv/g7cWPvPA3iUWtA8smLofYHojozYW17lNXa5NDRaPa+QE1QYcgVyNTHmyGu0ImnyAX1AJ1kbIfRwxsB/4iisu+2pSF1xtf4q+F7xJOthjVlFCuVeYHljKbURq2kKGgw0BE7LRRKPG/P6riV4F96fl4L/Qij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyeGO81K; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so3363511a12.1
        for <linux-spi@vger.kernel.org>; Sun, 25 Feb 2024 18:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708912983; x=1709517783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4cpaHBEdPSwYMPzpDqnA+dJ66X3qsQRUCH+N+Yn5wA=;
        b=DyeGO81KCXkMfgnhitlQ7xhGnRrDxDdkHCU3ysycczLoFSmaW0xxia3R+K/2cYR2TR
         pZSuq4DToqznh/6K7+O1IfFrcoE9zmup0L12Y/Mx+oV7qVz7McfiXgrwVhxu9M0411rd
         zKx8TQ83mx8ujqBMXKzRkQNVhPsVwX4Yis27I2ZAgsNEqiKui5+wQ3it2GT59FNLBN/S
         GaFcqX+3uVUMwE2UQ9vaBal2CPGFIRW60bRRJUE4u2HoCRE8OzRjINfh9fnLdP6ulv/t
         6HlqfnN9oOeZgcP3Q6SyX0Tu6F0P/ElO0JsNq9yKqqJdmlguN5II5opEa4JHcUbvK8xR
         TG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708912983; x=1709517783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4cpaHBEdPSwYMPzpDqnA+dJ66X3qsQRUCH+N+Yn5wA=;
        b=rUhBRpTQKIA9T3xGDnV8IB+1SFM4LbmKTnXUbLlG4HhPwEtoQFpWYHEnPQdtXE+ozI
         npYFhfManG9hx2doDgYL0oyMqIdmIpPQhk7I5Xgp/sBf5NG5XIMAlqvlLiiZLSoNbw8X
         PZmUZvRXnp8zegAzVfVhTEWMchrlklE5ukASOhaSxDX1xCBjC480K61IdEIUdN5c2e5y
         ZuJPunKB77sKlNXdciTyNY5YdGF43xM7vzy4v1TaSZL8GVUP7G1Ug0a4ICJivAcUcFVy
         pey27n3ksuFyUiOkMtG4pZp8N8zeNARQwByhUhYusODohXq+DDAR3N0NQ5beOc5atyAC
         KhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUzvYA7fAx52668gYrod13YatDBVX1cj0N6M1jYAzsQS5JTAGN7kRKR/DT/HXrtyeasHcK/q8wNAanmOmRJrcwo12P6Rgtf0kL
X-Gm-Message-State: AOJu0YycmS3XRRLXS8K5fh+s07SF/NyVQcX5J6sh231JZH9Vuw46+71h
	u1/dQPKX4u7XsmiMylC7nKV9Y5Bk8oe1yUuuOTLtasp0GWbfMaWeTpXQaYpb3Vlgnr2OmG6uIVf
	Rb344W4m6iGCghznKqxqIoWJBiaI=
X-Google-Smtp-Source: AGHT+IEwG4fJQD3kx53nN39VRnBZjVmb0USWLLq2/UFkAVhbtU/RhqBXA8UMx4wIPqZM9NwIMAP96pMulpvNonxc0mo=
X-Received: by 2002:aa7:daca:0:b0:565:ad43:2229 with SMTP id
 x10-20020aa7daca000000b00565ad432229mr3033648eds.15.1708912983382; Sun, 25
 Feb 2024 18:03:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
 <75a22482-0d2a-4e0c-86e8-3a8e71f2f403@linaro.org> <CAAQoYRkVYjs_+7cSc5oU4qKoi3_5My8xk32RWq3O5V5D_xBg0A@mail.gmail.com>
In-Reply-To: <CAAQoYRkVYjs_+7cSc5oU4qKoi3_5My8xk32RWq3O5V5D_xBg0A@mail.gmail.com>
From: Alvin Zhou <alvinzhou.tw@gmail.com>
Date: Mon, 26 Feb 2024 10:02:54 +0800
Message-ID: <CAPhrvRTW0z950mZsuaFRW0_vs1NmOU+L_FKM_64UdTwLwVsQzg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Add octal DTR support for Macronix flash
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org, 
	pratyush@kernel.org, mwalle@kernel.org, miquel.raynal@bootlin.com, 
	richard@nod.at, vigneshr@ti.com, broonie@kernel.org, leoyu@mxic.com.tw, 
	jaimeliao@mxic.com.tw, Alvin Zhou <alvinzhou@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"

Hi Tudor,

>
> Hi Tudor
>
>
> >
> > Jaime,
> >
> > You're so close to have these integrated, I see there are no major
> > comments for the patch set. Would you please address the comments and
> > re-submit?
> This patchset would be take over by Alvin.
> Thank you for always giving useful and kind advice.
>
> >
> > I plan to do the PR next Monday.
Because I just received the patchwork from Jaime, so I need to spend
some time studying the comments to prepare for the next PR.
Thank you for your understanding.
> >
> > ta
>
> Thanks
> Jaime

Thanks
Alvin

