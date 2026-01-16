Return-Path: <linux-spi+bounces-12452-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A72D38761
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 21:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5324F30BF31C
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584D2F3624;
	Fri, 16 Jan 2026 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="dh0RljoG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958433A4AAA
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594652; cv=none; b=kt/Z1XFj0KSMC+v9doMMjdhX4bvxWxpt+2Ok8svDNMqYVrEsse+qpWYJTQZggCFpBgQv8WdQbMSp1SCg4ORUPcQX7AGumC2faSUQAaX2eMddBbF0WgvkL7re+H3w1JrBfSUG3YiBkkpdpllgt1XV2ez34UJySRRHGQxG/7FugsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594652; c=relaxed/simple;
	bh=tS9opwpyQkJabPl6guzHPoUbf+cSRZDvdcAs88GlNYk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PH3lnQXQrPCib8gcHRPUbjXRBe7vDDjQtrzTWVdJZM5XDoArQZHwTxAYTXmlxOhLZHJ0IUU2PfBUXwhjerfi/2gl9vDTleRd2bQBXYg+fPQ9xIwyl/F+M9RgBJuyl9j5XuBrdTggsCLmg4U7WVNpJfpvQCvIaU2L0RuHhgTeZ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=dh0RljoG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29efd139227so15532425ad.1
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 12:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768594650; x=1769199450; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU7NnvOJ9a9r9qIwFHpAEXlxad5Cnya/UDxG8mCUJcE=;
        b=dh0RljoGba4ROkLcTRD9r4tzLv439VMww0xKrmSIQ4nNxCf2NzXrZ4B6lsukF15gfC
         KT5tgcNQE+c1aO+yFhAiaiQ8Xg75wbLiJcBZIlaC63IfiakqRLYlIWpXAfDc7OyowCmK
         LpICJ9AeR4OzNJjuwufY5goc4cMC4QJjonEAnAqhMAPjjHFZfkGL9tIlqAxMoiiQ2iXS
         sEj9AW9ZwCoOWXMW5pIhc75eJkhc9569G57WOtwxVQFXa6BkkL7W6dVHNF2nLHpCp1xf
         oX9g3ZaRmT15lopUbagwYNP3LtzdzUYCf2HvMFcyr9LmWHzSslu+ykfg5AxG5R0I/oBn
         MkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594650; x=1769199450;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iU7NnvOJ9a9r9qIwFHpAEXlxad5Cnya/UDxG8mCUJcE=;
        b=Bjg5agbEmplGXaYA3NfcMKYN7tC6Khq6BOl24OX3p9LNKQfTGU3NfH8S3jJGITDYxT
         zK93mqP1Sn5JfPSYzKpdwpp7sQVgJX03eOCwHCh/iDOBSHfJoVkAbpLYzcmzjEiWewBR
         o/y+ILBpU/jMjjylSuo69Bp1y7TQiQSMisktbEai2P6rdEVLLm4Iey6cu46u/duiEbl2
         OfPsn4kEPw6rOHzwvt5pZEfdTcaMleYH82hBJU3/1tEJSvfurWeSOCgJDkhvPXEyLreo
         F2/Y2kPGl7g/hiNc3tKnNrwHx6VlYnXTjjiVXSUF8+uflNWaT256gsyV7a2ylKZVjBKP
         Vfhg==
X-Forwarded-Encrypted: i=1; AJvYcCWwMR8P74Kd6nhQI6FPDCbrH3PWtmXB9M8U6VjE1yzo4F/stWgJlVYpbDPodo0OWVJ0uRzUr9yJvTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+5/psbnat0VI/0tEBzJWp+9VwuT2wHN/AFX0YhXboanFEbA4U
	FcPW5cHTs8m44cK3bJjsXXtC2TzduD45H7uwVT1NcqJTCgyU+klwGG5FRBuypC1gtrc=
X-Gm-Gg: AY/fxX71TXmpykFzydS3YmMElLwIaFlwkEDL90tyn7jl9VcEERSiE8aA4DxCcZ7jgkC
	DCRDilCy0PUHCY1fDbvkD2uy3AIHLrR0cOv/HfXnEAkRR57AaOdE4jNQOMELRl72ilqEUBQg8C+
	8GvJ+3UGY69rmy7q5yP3+A5a383aruAb36g3y5DJToC2q+BJ86HrpQTp5g8EdMzBtUPArEifCLt
	I5Rg5QUBJYspf/YACCNQn9Sci5rYNrtN2Jp217zgD6GBvvnObZvqKKOppQLiRYX6WdEu2YKAfZ5
	QHGlsoxk74inB0VZst+3gwxDB5yfNYr2wPtOpq782ojF9m9xHKQcDlAFcQVFLNgX2jYV8Uygdam
	R4uVzDdd9UFOjpLpQZM5bzSXZV+K9d5wU1LmZf05H0dkBPJGiM6xbXx91yxFyQvuxpxWEHZLuD0
	QZGOdk6BSRt+bQmd6ih/SnOR/hzuR+1tPpFl2pb6n8h/8RI4bSm4ULvBB2vwpaDOEMp4xMl8Scx
	F9oVPqgjA==
X-Received: by 2002:a17:902:ccc8:b0:2a0:8360:3a74 with SMTP id d9443c01a7336-2a7189713fdmr32122585ad.51.1768594649704;
        Fri, 16 Jan 2026 12:17:29 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190e785fsm28043905ad.41.2026.01.16.12.17.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 12:17:29 -0800 (PST)
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
In-Reply-To: <608a92f1-9403-45c8-b4bf-085f85876aad@lunn.ch>
Date: Fri, 16 Jan 2026 12:17:18 -0800
Cc: Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E82DCAA8-720D-45F5-ABDD-289A06FE7CE5@nexthop.ai>
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
 <12f527c6-7728-4512-a4f1-08c778627ea8@lunn.ch>
 <87C51F3B-7770-4BFA-8BBC-5E83A71920E1@nexthop.ai>
 <608a92f1-9403-45c8-b4bf-085f85876aad@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 16, 2026, at 12:11=E2=80=AFPM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>=20
> On Fri, Jan 16, 2026 at 12:00:35PM -0800, Abdurrahman Hussain wrote:
>>=20
>>=20
>>> On Jan 16, 2026, at 7:23=E2=80=AFAM, Andrew Lunn <andrew@lunn.ch> =
wrote:
>>>=20
>>> On Thu, Jan 15, 2026 at 12:33:28AM +0000, Abdurrahman Hussain wrote:
>>>> This makes the driver work on non-OF platforms.
>>>> Also, make irq optional, since the driver can already work in
>>>> polling mode.
>>>=20
>>> Are you saying ACPI cannot describe interrupts?
>>>=20
>>>   Andrew
>>=20
>=20
>> It can. We have enabled the interrupts through ACPI on Xilinx I2C
>> block and it works great.  For the SPI block we currently have an
>> issue with our FPGA. Luckily the driver works just fine in the
>> polling mode. By just making the interrupts optional makes the same
>> driver usable on a wider range of hardware platforms, with or
>> without the interrupts.
>=20
> It would be good to split this change into two patches, one making the
> interrupt optional, and one swapping to device_foo calls. They are
> logically different changes. And the commit message can then explain
> you are doing this so the driver works with hardware with broken
> interrupts.
>=20
> Actually, you need three patches, you need to change the DT binding,
> spi-xilinx.yaml, since currently interrupts are required, not
> optional.
>=20
>       Andrew

Sounds good! I will split this change into three patches and re-submit.

Thanks for your review, Andrew!

Regards,
Abdurrahman=

