Return-Path: <linux-spi+bounces-12501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AB0D3B71D
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE3030057CF
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 19:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799E145B27;
	Mon, 19 Jan 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="EZ4aibWS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E363238C1F
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 19:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850305; cv=none; b=ryPVAVgxHaqy4yiEU/O5LLIh2Z13Fm53KH6A2CZFtFjkIvikWkDc4Ljy3kvXJC4Ox302mzuR1B0o4mCSncC8szcq2i7GjC7ye4I984TZWVkw2rXF/c3In4jH2Yb7PsfIbQf3j8So/e+Ci6p3as0HG7Q+TYlOELLRIhWzLmOw9ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850305; c=relaxed/simple;
	bh=iMbbvDw3ImsVYXCbW3JGhdPTlgnkA/UoJxDgAjcWUeo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cLqmHjhcOJgzCyXMmTo99FhJxdvThzrCzB0CuFNcMpSghX1nJzX2XunCUZ+HN6mZYIdgcetRS1FH/6Q0D9vsy1dYdLTqo7/7S37n/0zzcbUJg/ETmkfryI7AnNCNB3XSlNaz3Gas5GrHc4SlxKEyZudoNbRr/MbkEYz7vW/zSrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=EZ4aibWS; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-29f102b013fso40547585ad.2
        for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 11:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768850304; x=1769455104; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rq/mqDmZq8gMZ+d2R8pkO8FovF44UTPXxgcytXXSxc=;
        b=EZ4aibWSRC3ydrbUX54TIPMsVD8CKAOdZA2miGzdnFKUsxVFq8NpyECbRirMeBn/yq
         nX2zob2l2+ArWdMeAuN/bMmpLS68kIN4sFKdMmIIfrNSH01k1UMuIYwj2luWaWYdEUi2
         8HL250QEvmDfmtI0NnAnj4m59htGKvLFMJ7R/NqYITWyviAi4NTL52+iNaBkLMqQ344k
         E/3aBZTrZ1XIfYi5l3XuMPFJkrsVO3tSLrozS7y3lwz/8Nk0OQitP1WQu5+MgmpHF2mA
         Hn9bMc8wjAqpBq40uFE7fI7OQYfx52vNLMQZL/CenV24pC9x01hhx0ifNaJxC4Rzerj2
         U4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768850304; x=1769455104;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rq/mqDmZq8gMZ+d2R8pkO8FovF44UTPXxgcytXXSxc=;
        b=P5bSakf7zL5CS9vrLSZxfyuzToOcGZliNOV4NTw8ALdO+WiBMpbFL6xqsC3El886w8
         TqnU7cTSqzXfU17qTWK47qRw3eyqfNME43mvw62PT9gkCfprv3xFPtiTaRLoYaG47p9u
         Oc69V6PlF5NBOWPMWpXts7co57EYmD7WDwsNPL4ZijY9M9Y4nZsQisCIEIw02h7LlqXz
         6aZEJzfZWeOhmPCoCTth4TgYLhD8AP0240zJTRev1ZQrF0sZp8kaJAt89EIXz2XirD8I
         9CKLByOw7XEtgLjo/6P7fBq+uNy3autD0kHcqBBl8dC65Vkhqr5Ge2/P5XtMSqA85Ax8
         bFyw==
X-Forwarded-Encrypted: i=1; AJvYcCXmRUy6/5q+8n4Zscq7rghNgu2f/QJFT9g52t0fGk1XkDH3VhvFeNA99y7C/dMi2/8qplXJ7O4W9Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNr1Edbz4gO2pcglF1pgzHEIqi3ZBzXzIf089G2KT8wS1WFljO
	YTC6L28NLrkqFkopqFImNWeBeXay4wdGRBRUu+ANBnaOCKGcXaUVhJ29ZJz2NBNYqs0=
X-Gm-Gg: AZuq6aIJUON2+yg7FIl0nEyi41rr4/6bejP6uaro9RSiSNU7R5rbCUlJ+gINTWdOxnA
	fcw+OBo6a5h9L7QGRFSMEaeK4VhmJiTX9jwMp82ap7hbx1pDtdL4Z/lvwh1ifeOvgd752BdfHjj
	yxAS97auXB/61DLlhmuU6Ah798y4FhX3Ke81CMO8MYnQ6Vi38+GVMYb1XHYZ55V4tXsNmcQWog7
	gCGJcf/I/uyvmhZx2zUxP1Aj4YE5n4qSlUIgoHn4d/H/ig/5XltDoNdeCJM218XZTi7B0YhGfYz
	Q6drJshKNGprxrR6QDx+4HLMLRVr0FkLZ9NMmar6ZGoGd2FIXLhNGDWCOXpxs0hzBMzE5EDm8BX
	FBRVNCNB99tqBsQoS84OlNsNkdh4Id8orxaIF4WAI0Cn0QkmzhP3dWeLjsgmFoS1cPiP3nf0s1V
	5RNpD5WkwevsZtAwOnzUIuDXzyUXIfo3LU7uirPdriMDtsXwTnDH4Uny1u
X-Received: by 2002:a17:903:2446:b0:2a0:af76:f8cf with SMTP id d9443c01a7336-2a71885839cmr129978275ad.2.1768850303599;
        Mon, 19 Jan 2026 11:18:23 -0800 (PST)
Received: from smtpclient.apple ([2601:602:8701:f0de:dc5c:239b:cee7:ca39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbebasm103144495ad.55.2026.01.19.11.18.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jan 2026 11:18:23 -0800 (PST)
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
In-Reply-To: <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
Date: Mon, 19 Jan 2026 11:18:12 -0800
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
Message-Id: <31207BE9-C83F-4B4D-9A3F-7F25DF574E89@nexthop.ai>
References: <20260119-spi-xilinx-v3-0-4566c33bac0d@nexthop.ai>
 <20260119-spi-xilinx-v3-3-4566c33bac0d@nexthop.ai>
 <8436e914-429f-40b9-8e6f-ec3b02702cad@sirena.org.uk>
 <69F83558-4675-4FC2-8656-BC6E3481AD65@nexthop.ai>
 <9e559e33-4f2f-40d4-a15f-584548bd6057@sirena.org.uk>
 <05D2CC15-DD6B-40F0-BFF0-3264D4FF96ED@nexthop.ai>
 <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 19, 2026, at 11:01=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 07:52:35PM +0100, Michal Simek wrote:
>> On 1/19/26 19:38, Mark Brown wrote:
>=20
>>> This was specifically targetted at some embedded x86 systems where =
there
>>> was a goal to reuse device tree bindings for things that just can't =
be
>>> expressed well in ACPI.  _DSD is generally considered tasteless for =
more
>>> server style systems, AIUI the general approach preferred by ACPI
>>> forward OSs is to use some combination of DMI quirking and =
registering
>>> with a per-device ID (like the per generation fake PCI IDs that =
Intel
>>> uses for all IPs on their SoCs).  Just blindly accepting _DSD can =
end up
>>> with something that's not used because it's not what the ecosystem
>>> wants.
>=20
>> Is it a better way to use auxiliary bus as was recommended by Greg in =
past
>> on drivers/misc/keba/cp500.c review?
>> =
https://lore.kernel.org/linux-i2c/2024060203-impeding-curing-e6cd@gregkh/
>=20
> The driver there appears to be doing runtime enumeration based on some
> EEPROMs on the system and creating platform devices based on what it
> finds there so it's a bit of a different thing, the aux bus suggestion
> is about what the code that does with the data it got from the EEPROM.
> This patch is for something described directly by firmware so there's =
no
> way we'd create an aux device, that's purely in kernel.
>=20
> I have no idea what the hardware this series targets is (other than =
that
> it's using a FPGA) or if there's even a motivation for the change =
other
> than code inspection.

We are using this on an AMD Ryzen Embedded V3C48 based system. This is a =
data-center switch using Broadcom TH5 ASIC with 64 port OSFP cage and a =
whole lot of hwmon/pmbus and temp sensors. We have an AMD Artix 7 based =
FPGA that sits on PCIe bus and exposes about 80 different IP blocks (I2C =
and SPI). Behind each IP block are various devices. Each of the 64 OSFPs =
is handled by its own IP block (i2c-xiic.c driver) and is wired to one =
of 3 MSI interrupts.

We have implemented a custom irq_chip/gpi driver to manage the =
interrupts.

All of this gets automatically enumerated by kernel and works today, so =
there=E2=80=99s strong motivation to get this merged. It=E2=80=99s not =
just for code inspection. We are currently using 6.12 kernel.


Here=E2=80=99s an example of what a SPI controller/device would look =
like in ACPI ASL:

            Device (SPI0) {
                Name (_HID, "PRP0001")
                Name (_CRS, ResourceTemplate () {
                    Memory32Fixed (ReadWrite, 0x80950000, 0x00000200)
                })
                Name (_DSD, Package () {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package () {
                        Package () { "compatible", =
"xlnx,axi-quad-spi-1.00.a" },
                        Package () { "xlnx,num-ss-bits", 5 },
                        Package () { "xlnx,num-transfer-bits", 8 },
                    }
                })

                Device (NOR0) {
                    Name (_HID, "PRP0001")
                    Name (_STR, Unicode ("TH5 Boot Flash"))
                    Name (_CRS, ResourceTemplate () {
                        SPISerialBus(0, PolarityLow, FourWireMode, 8, =
ControllerInitiated,
                            120000000, ClockPolarityHigh, =
ClockPhaseSecond,
                            "\\_SB.PCI0.GPP6.FPGA.SPI0")
                    })
                    Name (_DSD, Package () {
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                        Package () {
                            Package () { "compatible", "jedec,spi-nor" }
                        }
                    })
                }
            }

And here=E2=80=99s an example of I2C controller with a TMP sensor:

            Device (I2C6) {
                Name (_HID, "PRP0001")
                Name (_CRS, ResourceTemplate () {
                    Memory32Fixed (ReadWrite, 0x80a40c00, 0x00000200)
                    ClockInput(25, 1, Mhz, Fixed,,)
                    GpioInt (Level, ActiveHigh, Exclusive, PullNone, 0,
                        "\\_SB.PCI0.GPP5.FPGA") { 14 }
                })
                Name (_DSD, Package () {
                    ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                    Package () {
                       Package () { "compatible", "xlnx,axi-iic-2.1" },
                       Package () { "single-master", 1 },
                       Package () { "clock-frequency", 100000 },
                    }
                })

                Device (TMP0) {
                    Name (_HID, "PRP0001")
                    Name (_CRS, ResourceTemplate () {
                        I2cSerialBusV2 (0x48, ControllerInitiated, =
100000,
                            AddressingMode7Bit, =
"\\_SB.PCI0.GPP5.FPGA.I2C6",
                            0, ResourceConsumer,,)
                    })
                    Name (_DSD, Package () {
                        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                        Package () {
                            Package () { "compatible", "ti,tmp464" }
                        }
                    })
                }
            }=

