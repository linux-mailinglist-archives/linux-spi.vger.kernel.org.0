Return-Path: <linux-spi+bounces-12505-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A2D3BC5A
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 01:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E53CB302A44E
	for <lists+linux-spi@lfdr.de>; Tue, 20 Jan 2026 00:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254B51339A4;
	Tue, 20 Jan 2026 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="A/WkIfYG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C528DC4
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868420; cv=none; b=KXbBbTCp6Ulvl/q3yYnP4B5samsvKZjzBCzAqXBLRh6l6qTakBDfJ+xTEKa6AcJ/urbEIObDGT/pzTZ9lgKzHnQSERtezsOwDmu8vNGk0muPWNjxVpudNU6hW2I64foXsUdNTRSGq6psp6htc6z/x2+u3eNCTShOjtdWJDYX+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868420; c=relaxed/simple;
	bh=jjrs0we0WdDIP1AJN8Se8u/3bc2RavIuvXmJDIcQYDs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J8M8Ml2K1SXQi3YZyZ+k23g7YhezwU3jj0ypRlT4qXMYOa41h40JgVMpgpjKF3I/rq5TPJshthdMjlRKJQWrDwizrDL4rmmC7VP0jSHpk5O/NBB1+nD1Crest/6fjnlod9ZuKFX6HRvXeiIzEwX9zMAgVaVqBQEF4HWQNmTwzLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=A/WkIfYG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81f3fcdb556so2173328b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 16:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768868418; x=1769473218; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeTXeD4lve394SS+NlEGV1e/pJB7b1y6Fb1pz4gtbKY=;
        b=A/WkIfYGBRKw3ZFGru1qAaXNzdxQxuc67brnaJFxOi1cZfJVeFGDtXL1b5NJXxLGvu
         bre+RWgkIQJrZk/+pTKlr1JN1ZcQaZGEQ5dNCFCsjdjq8OScq6laMK5QuhTGXyGnyMs+
         L1GjKouSQxjjISlmiG9+4Br9q1niB06CFchBkLi3tQvgR9Xxm5PU+Q1TdrkSeVXBTgH4
         yRvoYkcEAyP/44OBxYqejcyjp7dw28WZmoq0/MDIgTF41oAIFmUbJ7BT3pEI/PnrKpg0
         eaymjruLrdKmAKSfIZE0KvqaWmMLkoET/Z64ovYdBoWBvpxQW7bVaN31sTjogC5bvG2j
         ChcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768868418; x=1769473218;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VeTXeD4lve394SS+NlEGV1e/pJB7b1y6Fb1pz4gtbKY=;
        b=oHZh9m1i8K/hDoAhRkDtbZszqJFCEoIjONEiu53DYKK+HAwRs1scCGzKtL/8dBsBWx
         k/dxMknqsneBdPxRbSMYIN+gIaVkKKBMQSK8E8UPQmDoACxT8CPoN4uwAH2K+nPQ5klo
         8A7A4NcNjYLxOz40GhZKFz57UcbLYwATPKu+FfnMWbV8G+QEy48p5RyRrWttmQhtGD0c
         E3zFtw9VlHx4u2a/NrOZ/2hHwLaruDp9vmhpDpP8+ye2f10SK8C5Rf5jZVe4V6UYlJTU
         aQ4DgLCGdXuGUH/GzO5Gblz6+1CbLxK+sNUyIORFxSHwvYBdw1CPTMG1yO8xErWmp2pf
         Bkwg==
X-Forwarded-Encrypted: i=1; AJvYcCXXIlPdU77J2Jg7WZko6/yGLqdNmylhbzfjQsxyXDJNeLDlO2N9vW/RHCWAo5KfFzJti6OJxaKVOx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXRYJYxRaBqMUjAgyZ/7hV0N+7PkIwlvhSDIHZbtwOhQ3b0P9
	2VzgHBIpgYqZ6QRPXsI+1JkGx1Za4W7MIHNLx7+33GFiMalu3cnWkgmaBuKcBy+XKriHkvg4duj
	tdV+LBaI=
X-Gm-Gg: AY/fxX6aYqWrCTdjGvA6928IVT5k4mjcvrO7TD+XYUFsWqO50UXlvq23kI+xHhggzaG
	tk5IY597kNYdV1BckLYaKy9L6g6q4xt24faSiouV36sRnXkBZCZOXM5XRxQLxoDooc27VM5pSC0
	ViiX/A9DLL0igov0N9Qi8BVQiV9NTa809anEe563qn5CzIrksxLxfhK4GcR+6oAJHOBV5S/U2mR
	NJkjcitSuUGqi7iJ7N9EIgN6ZVA5LgWg8NBERQphotvURpNS4qpinI7yMT/oqABdYgRcBAf0rd7
	NMvUhmrCZfzfnywkALTeKA+R2Mx4UMzP3XivZeoECWyhNptMJfINmYac7SXsvh47e5yM0aXdWef
	juruQpNySNfUnjwCtDMQESyXd3jnYNhjWkujaKduwZn0h6faM8Ay8eAhq6zH04QByHNC4mjTGaP
	8/rlkWUzqr2kRokWi5uUQzH0yEFilqgBLxnKaj/qrxJ9Q9fDlJNwOWZAaAPEgmJ8EEpjVm5jbTG
	N/nlGznUw==
X-Received: by 2002:a05:6a00:13a0:b0:7fb:cf05:93cb with SMTP id d2e1a72fcca58-81f9f69046cmr10992965b3a.1.1768868417895;
        Mon, 19 Jan 2026 16:20:17 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12911c2sm10078142b3a.46.2026.01.19.16.20.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 16:20:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
Date: Mon, 19 Jan 2026 16:20:06 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
References: <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 3:20=E2=80=AFPM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 12:30:43PM -0800, Abdurrahman Hussain wrote:
>=20
> To repeat what I previously said:
>=20
> | Please fix your mail client to word wrap within paragraphs at =
something
> | substantially less than 80 columns.  Doing this makes your messages =
much
> | easier to read and reply to.
>=20
>>> On Jan 19, 2026, at 11:56=E2=80=AFAM, Mark Brown =
<broonie@kernel.org> wrote:
>>> On Mon, Jan 19, 2026 at 08:17:46PM +0100, Michal Simek wrote:
>>>> On 1/19/26 20:01, Mark Brown wrote:
>>>>> On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
>=20
>>> None of this looks like something intended to add ACPI bindings,
>>> it's not clear to me how we'd even get the device instantiated on a
>>> normal ACPI system.  There's no ACPI IDs defined (and there aren't =
any
>>> existing ones), just a conversion of the property parsing code.
>=20
>> These "random" cleanups make the spi-xilinx.c driver work on non-DT =
platforms.
>> Which is what the cover letter says.
>=20
> The cover letter just says:
>=20
> | Transition the driver to use the generic device property API.
>=20
> | Additionally, make interrupts optional to allow the driver to fall =
back
> | to its existing polling mode on systems where interrupts are either =
missing
> | or broken.
>=20
> which doesn't mention any motivation for this, it's just a statement =
of
> what the patches do.  It's very unclear why this is a series TBH, the
> interrupts changes have no visible relationship to the device =
properties
> conversion and should have been submitted separately.

V1 was a single patch. And the commit body there was:

"This makes the driver work on non-OF platforms.=E2=80=9D

See https://lkml.org/lkml/2026/1/15/66

It was suggested to reword the body in imperative mood. Maybe that=E2=80=99=
s where it got lost.
I can re-add the mentioning of non-OF platforms to the cover letter to =
make it clear.

Andrew Lunn also suggested to split it into 3.

>=20
>> We are trying NOT to introduce new ACPI IDS, or fork the existing =
drivers.
>> But rather, to re-use the existing drivers as much as possible by =
relying on the
>> special DT namespace link "PRP0001":
>=20
> What is the goal in avoiding using native ACPI bindings?  PRP0001 is a
> workaround for cases where you have things that ACPI has never dreamed
> of and can't abstract well but which have already been handled by DT,
> it is not something we're aiming.  The hardware you have described
> seems like fairly normal server style hardware and like it should fit
> well with normal ACPI.  Adding ACPI IDs to existing drivers is pretty
> common and standard, I'd class that as reuse.

I did not intentionally avoid introducing new ACPI _HIDs, but at the =
same time
don=E2=80=99t understand the need to, especially when PRP0001 workaround =
works and
it works well. We don=E2=80=99t own the spi-xilinx driver and neither do =
we own the i2c-xiic.
These are standard Xilinx IP platform drivers that could be made usable =
on ACPI platforms
by just switching to device_property APIs. Which is what these series is =
trying to do.


>=20
> As far as I can see from the example you posted the devices are all
> fairly standard and just need IDs assigning to work naturally with =
ACPI.
> There's possibly an argument for using PRP0001 for the flash given =
that
> it's not especially idiomatic to have OS visible flash on ACPI =
systems,
> usually flash would only be visible to UEFI, but equally the =
description
> would trivial and systems wouldn't have to use it.

You mention =E2=80=9Cidiomatic=E2=80=9D a lot. Are you implying the SPI =
NOR-flash devices should
not be exposed to user-space? Then why does the spi-nor driver even =
exist?

We have a SPI device that needs to be accessible from users-space in =
order to
=E2=80=9Cflash" various FPGAs. How do you suggest we do that?

Also, there are hundreds of drivers in the DT namespace that are missing =
the ACPI IDs today.
Do you suggest adding ACPI IDs to every driver just so it=E2=80=99s more =
=E2=80=9Cidiomatic=E2=80=9D to use?
I am just trying to get this 2-line small change merged so we can start =
using the standard spi-xilinx driver today. I am not trying to boil the =
ocean.

>=20
>>> You should use whatever firmware interface is sensible for the =
platform,
>>> if that's x86 that's always ACPI.  For other architectures there's a
>>> split with servers using ACPI and more embedded platforms using DT.
>=20
>> Which is exactly what we are doing - using ACPI on x86 to describe =
the hardware.
>=20
> There is the bit where there's a PCI bus in the way and you don't use
> ACPI particularly idiomatically...  I can see the dodging out on the =
PCI
> bus description, but the way the devices behind the PCI bus are
> described seems confusing.

What exactly about this usage is not idiomatic? Our PCI device =
description in ACPI looks like
this (GPP5 is the PCIe bridge under which the FPGA is located):

    Scope (_SB.PCI0.GPP5)
    {
        Device (FPGA)
        {
            Name (_ADR, 0x00000000)
=E2=80=A6
            Device (I2C0) {
            ...
            }

            Device (I2C1) {
            ...
            }

            Device (SPI0) {
            ...
            }

            Device (SPI0) {
            ...
            }

        }
     }

I have provided ASL fragments for I2C and SPI earlier.

Which part of it is not idiomatic?







