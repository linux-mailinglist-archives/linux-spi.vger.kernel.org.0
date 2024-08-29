Return-Path: <linux-spi+bounces-4436-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D67964CDC
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 19:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9018B1F21559
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816291B5EA0;
	Thu, 29 Aug 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNFOxpTx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09A1B151F;
	Thu, 29 Aug 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952734; cv=none; b=GlIdRazAtjDCzBCuN7eklZCxHK00L4bW8dn0IkhSS6FDFsZ0+kRgECP9hFn5CFO/zaAmyewzmNzuyr8ZalVwB4niZb2Vmyyghha2eX/gjkwHPrdbEe3fN82UH37gjdHVFI4CpBliudNxzXx7B/I6QZ6KjgQGzQJLHS3Lf7re8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952734; c=relaxed/simple;
	bh=Ci1IjLrgxuKopOrBB7mS85mXNkrMaR11ehThLezyhOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oc7ZIfFze82vAJwCBdIDfD58mUvr+mfzQAYgDj64FNr9ETv7g+JLpJgR5LDBsYLJEKN3xyDgxUCUku8BOgWF7MR0BRZWReKLjyqwDaHHsP8CrlUIRPR2chSrMjmtG6XQTbQg/1zLNHZh+KRpS0WfeZm7lPlc/jM984rx1080nyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNFOxpTx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-533488ffaebso1083509e87.0;
        Thu, 29 Aug 2024 10:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724952731; x=1725557531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci1IjLrgxuKopOrBB7mS85mXNkrMaR11ehThLezyhOU=;
        b=PNFOxpTxkkPwnuJ69dHp5U4OHpn88Fgrlo9PNBPqG7pafQgnxAlujBNFqAsfxlcwdm
         ytqtnrd7dNm9CscP6ezFB6LGs42gYFOqL/Fh5aDmILNZnwlGzqV0YHNjnWqcYX6OBU9a
         Gt7uHE4BSa/3meedlxdZlNoW8yUhwFcRxuWkDWw1UGV684yAbg8x5HA1i2LerG30F12W
         qIkjgMSY3d+Clq5P33zj9d5hlx3WsD8xXt/B+x45Xu/vsxqtjSbNAkGw/S4fWIiEU587
         PFlTJn0xlxLqjBXLErJkStIgakyOYygj5d9FjY8gZpb9RiUlxW+4/oO6QEDiwmwsgKA1
         I1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952731; x=1725557531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci1IjLrgxuKopOrBB7mS85mXNkrMaR11ehThLezyhOU=;
        b=r0xFfE/UV1VtJN0F0dB/dw0dlYVNFBp4oujc1me7cx5YGonpZ7G81ELf3wxAeZ1EGi
         fosq73T00pHVD36ja4Y3RMY2FLOtpS5X/7r4LKFMXOUuqZhoNBXK21HkMapP469D//Cj
         FiFjSuJUGuZCIETJ/b5q5QAaC+LjgGUdS3ki42vz601ZSnlRvkmCpSv3Eo4N50R1gPho
         SC7XzFpQlltBhO+4NnZOcsg9uiLB3V3WYeoGjw9YLzrCVjj2Fptq9awZ4xx7vQBE1WTU
         KcqFDissxUJ5w0CeiC9KzDfBSznMqo9hnP/ugEd7Vchm+BItiGHhq5K6Mwfg7SPG79Vx
         kipA==
X-Forwarded-Encrypted: i=1; AJvYcCVYr2wS9IYnNVzVRg0fFms0wVrH7HfxKaPjuEoDgfi1aDi95YL9hC74RyhqxAJgOSYD4QCpUfPalA1S@vger.kernel.org, AJvYcCWyi4RB/JhyR5uc+eCXg03bLuTaL2R5wuCNjKMpv8dJ+hjvfCSJRbJm3XU3tkggddNN9xiqnm1YSA5T@vger.kernel.org
X-Gm-Message-State: AOJu0YwgKLpBuUyXRb/f8e/mgk7SKKRM4qx6WT6Xcku7LSs8/Nuz+e6r
	oBfqgO/mS3GYUurZAXsub70WjCi4y1lRCq6nRtOr4GYKGlAU/Xtt04ZInU/HmsJjDv6aharS294
	4v4DkIVPzZmj2+e7gm15ESnh/i54=
X-Google-Smtp-Source: AGHT+IHJDiN4QUGh0SUTrhUUPUdUEZ8AfwVAwRa5oZ5JGf74ystLR3IEm6UIkr3QuY22L0L2SyneKpFkXIE/amdk9zU=
X-Received: by 2002:a05:6512:b84:b0:52e:7125:c70a with SMTP id
 2adb3069b0e04-5353e5ae6damr2243321e87.47.1724952730222; Thu, 29 Aug 2024
 10:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719111210.1287783-1-festevam@gmail.com> <20240719111210.1287783-3-festevam@gmail.com>
 <574443966.JY4mfKhWER@diego>
In-Reply-To: <574443966.JY4mfKhWER@diego>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 29 Aug 2024 14:31:58 -0300
Message-ID: <CAOMZO5AseqaMMR8au8gPE4oUkUWnhxeGO5CeZTknWck9meFmug@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: rockchip: rv1108-elgin-r1: Do not
 describe unexisting DAC device
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org, 
	otavio.salvador@ossystems.com.br, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Sat, Aug 10, 2024 at 6:23=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:

> Acked-by: Heiko Stuebner <heiko@sntech.de>
>
> Mark, do you want to take all 3 patches (fine by me) or just the
> first two?

Mark has applied the spidev patch on his for-6.11 branch:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=
=3Dfor-6.11&id=3D5f3eee1eef5d0edd23d8ac0974f56283649a1512

Could you please apply the other two to your tree?

Thanks

