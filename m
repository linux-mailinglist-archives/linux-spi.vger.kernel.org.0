Return-Path: <linux-spi+bounces-12450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB420D38658
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 21:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFA3A30082C9
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC7241139;
	Fri, 16 Jan 2026 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="jD2xQ+hs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517E51FECCD
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593648; cv=none; b=JJSpk1IL79QuMmm64+gd8iz1EABRX7ZOjZBalrCs1IYJ4QZNKfdSP8a+wt+n4UMG8Ly3xusV41gbpXszWfNN01vhcfbHXjKwBwJy8QMCLxOccGPmlKum+tQgLD8GZnTc9jZhU5LFnb7P027se9gtY14JyoXdrP2ZbGJg2huBBjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593648; c=relaxed/simple;
	bh=tkme66KHjDnBGv0Xadu5OkoP1gXcr/YAmORPBgPPDiA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=T0PiQWiTfT6cJLb6pGU74TQmKwekQyKZIXn5jERD7/mk39WQEpmmisKAuykH5sfrk1ap61pNMrhweFURmyVF7mULQ98GHx/+TirXjNZBvKWlT1Ok0Gdik0tgP9f/+YTrCy02rykkkf08VfbhzT/rug3agjZGB197hLudIXb5I98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=jD2xQ+hs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c93e0269cso2183341a91.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 12:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768593647; x=1769198447; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGbPPoXy/VbK4qXGtABm8Nu2UOw6xSYC7oeE8YmhQMI=;
        b=jD2xQ+hsd3nd0O0oUBP4c/zjDffC4hkV5kKBQ6yknZ1KYTw3a6A4iIXD90Io3qKqhf
         Z/M/hFCPWqvGV50e0otSTQQ1P0OFqbC7p+mMAx96IX4NmPdZCao6RA0zPdBFYDIOCBGF
         lowIM4XtBOa/IT4qjVHLtCfmurOKclYQXR2lrJf9Dr+aF74LYGG8b/t7OTX2DZljlJK1
         exACM75xSO9sU0lkivrS4UXTovbCHWF4arqWjLrG9mfbKh2AtzODcwndvNPivI6LkrwV
         JLCCbcAGJjJnavTsPCFpq4zneY7tFMzwS1EuRRQgM+pUU3CRABtWbgFD7b9CXiSH+yOg
         8EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768593647; x=1769198447;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGbPPoXy/VbK4qXGtABm8Nu2UOw6xSYC7oeE8YmhQMI=;
        b=uMUsnGv6fX99lhI0wiVg7nBu8wD+/DNO8BtaC9YlPU2Mr8jsb2MRloa6aRKXKosWqW
         Wvwb0ZnbkW3iDtxzoUqymx7HMOOmRjnQB7HN10eLyJPpaI0s68OnmicngS6NYr8FVFkZ
         R4f4oHDmDa9YyIu9O7ECKC07bpbjpsE5zrxBBuPXSermnyq+cJAp+2pV3slfo8adoXmS
         2CUjDaRpRerayl5jpSidXUOcMEU4/gakjgiwvjZ7mzhWsdlMxsajFIcOk/W27WkKe3Hy
         EL32T4Aeyz2EoSAKXIIBdx1wdwyQJrMFrM808+eM0OPCn9IzkYel9LizOKF3TRNL/s+B
         quaw==
X-Forwarded-Encrypted: i=1; AJvYcCWWrsqMYSdPHKea46KkEv6Pn+yo6bNTe0IHgnaVTNwPN4HEi8g3EB579juLb/EeBSieigxUj2M8dH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtzng+V4fzTUF0rt6YCP551FJwqGDpxfdacWvI68/S08Zt+iw
	DKGskguV+m4w6nvVrW2pCAiEctiBtgAjbvz3wEzcgFwsUrCNrXMRqEzLMxCPuyAMrfEoiQj70BJ
	r6huhS68=
X-Gm-Gg: AY/fxX7mFDkRayoaj4bMPXY8a/LqfZnxvpgchkj2ZaOKf+QhIVdxYFbdXt0dV92REF8
	/v9pjNMW1pPJOjC9IC4LP4l/A5YHIGp7CnYX2KzBsVUpl3h1VJDm7uzHvFuBb5kR2Vkd9vqqS9d
	z3MjCZrGocEiF7lmzZfQ343rGvEUgR9TyynRw8HM6rBL1H+yzwyijdRIBBuQyK8Sj0F5gQeQoyg
	SeiXn6nasPsPwE2teNnTX1CA7bV0Q94XkD4P2kMgyqxP86sCr0KLGPkJPFDzLrO615KUBAwJxAf
	VNptgdbF48vMJqAIGOUNkwGx5HC07dUaoxIMl4nIKfCU8rObUiBvtESj5T2UUI4Xi3cm4kfRjig
	OT/9kbQfzH9yJpApVuLNyRGILEXqKzC5ov5FbQijR/z2xFd4b7hSPSFzK9P0v3zs3XBZOa5ARLJ
	ExNy4G9uF+79ATpetlxAKjbmQ08M9Ng1irYcufeCk3lOlHvGWu25lnbLJwCJoEJikQavhmMVU=
X-Received: by 2002:a17:90b:4d09:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-35272c8de8dmr3516213a91.9.1768593646505;
        Fri, 16 Jan 2026 12:00:46 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3527312381dsm2750075a91.14.2026.01.16.12.00.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 12:00:45 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <12f527c6-7728-4512-a4f1-08c778627ea8@lunn.ch>
Date: Fri, 16 Jan 2026 12:00:35 -0800
Cc: Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <87C51F3B-7770-4BFA-8BBC-5E83A71920E1@nexthop.ai>
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
 <12f527c6-7728-4512-a4f1-08c778627ea8@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 16, 2026, at 7:23=E2=80=AFAM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
> On Thu, Jan 15, 2026 at 12:33:28AM +0000, Abdurrahman Hussain wrote:
>> This makes the driver work on non-OF platforms.
>> Also, make irq optional, since the driver can already work in
>> polling mode.
>=20
> Are you saying ACPI cannot describe interrupts?
>=20
>    Andrew

It can. We have enabled the interrupts through ACPI on Xilinx I2C block =
and it works great.
For the SPI block we currently have an issue with our FPGA. Luckily the =
driver works just fine in the polling mode. By just making the =
interrupts optional makes the same driver usable on a wider range of =
hardware platforms, with or without the interrupts.

Thanks,
Abdurrahman=20=

