Return-Path: <linux-spi+bounces-12503-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB16D3B864
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 21:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71B51300F697
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAA523FC54;
	Mon, 19 Jan 2026 20:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="kL1Je3yI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB723F431
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854657; cv=none; b=RVg4yM/696ivm8fxWpMeVZA+k03rqMbduo1xR78/pMT1sTl8QUycDyISHjShtU7Ew6RUfieQsU+UgLsHIVH+b9orMeyy2P9+R45PvVFeIBTLzDdBcPA52kkgDw/4Z3rYVQR+gvg3BybWCDyHtEZOMmH8k8/GjlUHGngnRb95Ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854657; c=relaxed/simple;
	bh=co0ZrxiIq0A64p3DHxltyOZ8IZsVooJ5WkXqfBjUBr0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GuYC9+PG8Zm0MZilHAn2IEjxOEAHeIWDBcYKIRsSCB4XtRIBpyFTaYi+EYABaCMGw74RIOni6pTNkDsojBy3EmYH1DF5fOgZspBTU9wtRL6YuDhYw9jQiP5zjMIvLSaNWDl5U9bbVNWwSIfoYlE8hR2KUfgu3WonR1Q1EuHPffM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=kL1Je3yI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0833b5aeeso47487345ad.1
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 12:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768854655; x=1769459455; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJmtHjW42S2n0YlNgk+uujnA9gZ+ERrhk/g3IuawkPA=;
        b=kL1Je3yI0fyxUcBxIWeUNJ4riMk4+dTemUkEbhm6wp7x/nkfeJTY216ipRo+FwCZXv
         +XXcgLEXXECLURu0gBGV+h6rSZ5gzv/Yeajp+eDlWKXonA5a/A8cb18JGNe22D6lb5AW
         Ua41+Ol36uR1rJCGBLWsgCDtL46k+S8uKozHnVDpZiFXx3UbvsaqrPeC6vEqrTmbw19n
         ezCrGQbaXPfnC0zgbNJChcwSrWLc07K6fZ7T3eIbK0c0sezvwCMUU0Y0NiUMe3Se2VhV
         W1g2M+2I1f2ojr+vU1UcwzaODZ3UT5MJc7j1llshYWIMBNL32iAxEhKu6uFvz13jfeoM
         A0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854655; x=1769459455;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJmtHjW42S2n0YlNgk+uujnA9gZ+ERrhk/g3IuawkPA=;
        b=nT1S5i23NWfyd+vmxwYpjE7cFbmB56CzboJ5dOOa8IVmOko52G7zhkMVBVeGeuk8Ti
         08jgVz2F1rK4+SDDLywsxXWPu3+yZXj6jUBlH3r5eOj0e3izrl0N0eSKNlpZwU1k9KqQ
         qDja36a/yxdv9gKJSq8qVzczgrsJbhWSXMi0STKJsYQKDwofyJI0CqOvUVfaTB7zx1KP
         g1frkgkEoBDCMdtsVFFux/5M4gBa/IsMQz57YwOIhqmS8VFB2x9oV9Cu8q1ru7ps+m6l
         oHToZNT4jPhbPIPyVUktSYvY8I49TDRf6g//EW3bpRiZaIpYKwocAL1U0sFPa3KFPY4b
         90wg==
X-Forwarded-Encrypted: i=1; AJvYcCVWrFfkVVOlrpeWu+vG7zUq8B6Apz5qhrLc3urcgFWyP0wW5DkBSTjNV+Ua0cm34fb6gzn8ue8rsjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZjC5eRY9zVejizrtjl7KD1dlqQVdvgl2SjRd62HV+JW8tJYec
	UuiuveD/V3kwRH/O1yd/IfHH3bqYGUgJPjDWicNfxtwgJKgw+T5DmzTUI4q/SplmsQPR20mOgcc
	6r95Tq3Q=
X-Gm-Gg: AZuq6aIWccWSkXAsIht/tjSFHr3rN5h7lx6gZtX9jD8TjUqcXljuYqfV+6YoV+ZfWTQ
	vPoSXWDhabnZn5NPH8wBbWG4awFAHF7poVL92ghvSWziCaLVkkqERZS7/UppxxxqrSL7zk+2drU
	9YY/Sl9saZu40PL+npTZbHihM8qHgzkylvJng+U1E7cWZ79iKoHP0EdYqYyzTm47GK0RHEHH1xt
	zDLh674U76beaVMQQy8fsk5GWYrWDJzFgTbEZC6s1m1uFRFiLBQMgIAVFM78OOkLbKM773c3gy6
	ejVsuSEYgzIRCJi/TsO+O0k+mLA/VySsnkJwH/jt450VbfsZYsNiIRciihbSdA3gj29ffBrTzaW
	KoTF/KKLVmUmeFdLN5BC7gfXU7xXg60rusjxz0h8z/78ES//byCJRKuDgprnfrHsTd1xKtWJcZu
	h+eITVAxF+fQ8Rnaplwhpg4cWGFcSEVylPn/8=
X-Received: by 2002:a17:902:c405:b0:2a0:b06d:1585 with SMTP id d9443c01a7336-2a7188f91a1mr110618635ad.34.1768854654686;
        Mon, 19 Jan 2026 12:30:54 -0800 (PST)
Received: from smtpclient.apple ([50.47.115.214])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb239sm102531395ad.70.2026.01.19.12.30.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 12:30:54 -0800 (PST)
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
In-Reply-To: <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
Date: Mon, 19 Jan 2026 12:30:43 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
References: <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 11:56=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 08:17:46PM +0100, Michal Simek wrote:
>> On 1/19/26 20:01, Mark Brown wrote:
>>> On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
>=20
>=20
>> If you know it I think you have multiple options how to wire existing =
drivers.
>=20
>> 1. ACPI - which is what this series is trying to do
>=20
> Is it?  It just looks like random cleanups.  We've got a change to =
make
> interrupts optional and this change to device properties - the cover
> letter just says it's a transition to device property but there's no
> indiciation why it's being done.  The cover letter for the series just
> says it's switching to device properties with no further explanation.
> It looks like a "that's the newer API" thing than something that's =
been
> thought through.
>=20
> None of this looks like something intended to add ACPI bindings,
> it's not clear to me how we'd even get the device instantiated on a
> normal ACPI system.  There's no ACPI IDs defined (and there aren't any
> existing ones), just a conversion of the property parsing code.
>=20

These "random" cleanups make the spi-xilinx.c driver work on non-DT =
platforms.
Which is what the cover letter says.

We are trying NOT to introduce new ACPI IDS, or fork the existing =
drivers.
But rather, to re-use the existing drivers as much as possible by =
relying on the
special DT namespace link "PRP0001":

"The special DT namespace link device ID, PRP0001, provides a means to =
use the existing DT-compatible device identification in ACPI."

Also from the same document:

"
Platform bus support

Since we are using platform devices to represent devices that are not =
connected to any physical bus we only need to implement a platform =
driver for the device and add supported ACPI IDs. If this same IP-block =
is used on some other non-ACPI platform, the driver might work out of =
the box or needs some minor changes.
"


>> 2. DT - on x86 not sure if feasible
>=20
> No, x86 decided not to use DT and shoehorn everything into APCI (and =
the
> x86 SoCs put their platform devices behind fake PCI that looks like =
PCI
> to the OS).
>=20
>> 3. platform drivers - as described above by Greg not an option on =
PCIe
>> 4. aux bus - for example keba drivers
>> 5. dfl - drivers/fpga/dfl* - used for accelerators.
>=20
> These are orthogonal to the above, they're Linux internal things not a
> concept the firmware has.  You have firmware descriptions of things =
that
> can be mapped onto platform devices but that's a separate thing.
>=20
>> Pretty much all current Xilinx drivers for soft IPs (spi, i2c, uarts,
>> watchdogs, etc) are platform drivers (more OF drivers because =
platform data
>> are mostly not used).
>=20
>> It means I think would be good to get any recommendation which way to =
go.
>=20
> You should use whatever firmware interface is sensible for the =
platform,
> if that's x86 that's always ACPI.  For other architectures there's a
> split with servers using ACPI and more embedded platforms using DT.

Which is exactly what we are doing - using ACPI on x86 to describe the =
hardware.

>=20
>>> I have no idea what the hardware this series targets is (other than =
that
>>> it's using a FPGA) or if there's even a motivation for the change =
other
>>> than code inspection.
>=20
>> I think all these cases are very similar. You have x86 with pcie root =
port
>> which is connected directly (or via pcie slot) to fpga. In fpga you =
have
>> pcie endpoint HW which connects other IPs sitting on AXI.
>=20
> What are "all these cases"?  For something connected via PCI I would
> expect a PCI driver that knows via some mechanism what's connected to =
it
> and then instantiates the IPs, probably as aux devices.  I would not
> expect to see the contents of the PCI device described in firmware at
> all, that's a big goal with using PCI.  If something is not connected
> via PCI that's obviously not going to fly but it sounds like you're =
only
> interested in PCI cases here.

Yes, we have a somewhat =E2=80=9Cgeneric=E2=80=9D PCI driver that =
actually doesn=E2=80=99t need to know
what=E2=80=99s actually =E2=80=9Cbehind=E2=80=9D it. It only implements =
irq_chip and gpios.
It=E2=80=99s the firmware (ACPI) that describes the devices as nested =
device nodes under the
FPGA device node. These HW ACPI tables are SKU specific, so the generic =
FPGA PCI driver
can be kept generic. And all the device enumeration just works. It goes =
with the kernel
philosophy of keeping the policy out of the kernel as much as possible.

All we need is these little =E2=80=9Crandom=E2=80=9D cleanups to tie it =
all together and make it working.

Regards,
Abdurrahman


