Return-Path: <linux-spi+bounces-7267-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994DA6BAE0
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892CD17E67B
	for <lists+linux-spi@lfdr.de>; Fri, 21 Mar 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7C2288F9;
	Fri, 21 Mar 2025 12:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIi5JQIh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B84CA5A;
	Fri, 21 Mar 2025 12:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560852; cv=none; b=nAfaM7W6rFdhN+CeIzVSQ5cwNRoneCub7/3p1qUq71wmEtiZoBSbNkq+9jlOUPuwRD8jtmjw2y4L2rw60leyJUA+dPonWfHINfRnPZuX8I8R7iEeGFHqkoeXikT1LjKvfQb7igQNjuc99Q2h+/eVRSI1CdEjdheoYSUt+SHJuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560852; c=relaxed/simple;
	bh=Ht/vT8VoEcLLA6YZmwCFXJrzLPLfvIg2VE6fD1HHk7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usL+5EGO7ByYg6g2v2zIi6QJURpJjugvg3G48+9mZ/k0DR8COc+c/4EVM/a7fKlHQc0OBA+GwK5DxGJCHsVP1ycXnQyVCjNPFdhbWTRgiPyIOB0xs3fvsVjHD0ESCYc+v7Nk7QMgrqDGTwUp66QOjf5Vx6uXPKRQZ6lGvyPlcxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LIi5JQIh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43948021a45so14943865e9.1;
        Fri, 21 Mar 2025 05:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560848; x=1743165648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ke2Crvo19o5/6sAu7Cpg/AcNLZ7i29sSYKGqu7mUG+U=;
        b=LIi5JQIhiJqTL+hlliVOXQck9ybgPjixnsUf4s0sjQ5OHicPa01hMFNWkuOZe6Ipzd
         UnNEs0CTzUTosuw/Sftjcqjx6S3SbCojZHJFO7ZDNjMRjOqCXnP9VLvIWmwPzVdsHbm6
         jyWZiTuaHhUO9dZ+scyEMYtswtbNJBGFG/qa10Ex450j9Is9rvEzSjYZ1KSi0Dix5Ldf
         kYAa+zDiGzz6jYb2w49U7ndSHy9oeApZTRwkiC2LyKgjUheWGPU+R6hjIJYtODvXOKFA
         17ppSi/KS0Qod+vsY7xDF5+MIJIPssIflUoJPMNbIsXgqFCQzVAvvaDqEgmrGI0JKk5k
         Lf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560848; x=1743165648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke2Crvo19o5/6sAu7Cpg/AcNLZ7i29sSYKGqu7mUG+U=;
        b=aFClomdemXalowtUkRUNw+s3FNL3InfN4zIXqCNAiRe8cdld56lbbAY0gM3rh3J7yq
         0ihwrFO+OfrVoC09xum2pMVIyPG5EZ5rmPV6bJdSzyETQbkefMTmcmCm0slbYZycFgPa
         bAINigZ65KKzbmHBMnkzIRt8Vi4FrImkPj5Ofjv9vOIhPVs59o5z/tUUyeWcuDGYdYm0
         OY+0dE927mJnlsFz3aoSwrINihDfj6ANyN1vBQY2tgXnH6iQhcR4HyQLLJX4yAyGZRkB
         SMrv8rhhbQGulLsXwpKbwoSrDSkZZt2i2z9FbJII8vuZ9AgyL+2svzvl8l7xeWi7dznl
         yFeA==
X-Forwarded-Encrypted: i=1; AJvYcCVtYbGU2ISbm9XdydYV5dtUvhkQSccMdsKxGzi64qKVXCu4UHXw64CXRILOs/R2/0mIuM9ygoy1GuS4@vger.kernel.org, AJvYcCXiOGAdz7cJltSMPh+K3rX+V9inSc/O2xELS9KUAZfrCAPvX4EjD1TW28Daq+1tchY5UUsDoJP2VWCIwwU=@vger.kernel.org, AJvYcCXxTpvHZshBmX04Y/9D5E+NQRWLmlHJJ9TEliqFNSonSbPNbV1YC+zTiVjIM73DTTthBEddAe+BClV/JFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3qu1nuzzZRMVtEPvDEaPaupSN1AuM3Vv4lZEQRVaJb862kSqB
	4Lr8udwUJQ+WFuJvJridZtXL2CZcw0MhQJvRAMdqQ80JXJgJ/nPm
X-Gm-Gg: ASbGnctfJM85KRBbbffcfZ0Xcr33qhE9KHzM6f9Dt6ej66XrTFAGsbou+S94DItBjyP
	MOawx98SQtzhigOGCQ01S6fKsjvhHmcw0MFzF2mX69H2WNE7uS3H4bQtz1fGicNShSUY/kcTwK9
	JWt1HfYapQ1arvqpSQOFzfLVH5AYNcFyVL0Ixka9uyjaFAteFfuZh81YAXeENbhoqTh22JwtDxd
	MhMinyTN+Kwy6XCKC32BAMn4igA9XU1QGeePqvQj6Abr+6dpAubAskuTpsUzvLtQTcAjTvCKca5
	BYMNaoZ140MM0a9arPtj2lwsa5O2I38uhA0cKhse88Qe79JtZtPU0dVcDYun7JlcrYl69hYsl/h
	ERKCGTC/KkZZpEnBsesfw+HSUBxsXvgw=
X-Google-Smtp-Source: AGHT+IFT/IJLLI846PtvqIajZtWRd7Km33/treO4lr9SzWx2lgVk2jKnlhS96coZdzdtH4zxuB+d8Q==
X-Received: by 2002:a05:600c:3b93:b0:43b:ce3c:19d0 with SMTP id 5b1f17b1804b1-43d50a3a059mr25414695e9.29.1742560847828;
        Fri, 21 Mar 2025 05:40:47 -0700 (PDT)
Received: from orome (p200300e41f4bef00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:ef00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f995778sm2310359f8f.11.2025.03.21.05.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:40:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 13:40:44 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Arnd Bergmann <arnd@arndb.de>, jonathanh@nvidia.com, 
	skomatineni@nvidia.com, Mark Brown <broonie@debian.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rmikey@meta.com, kernel-team@meta.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li, Jarkko Sakkinen <jarkko@kernel.org>, 
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
References: <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3kv7gh7vhshn6sce"
Content-Disposition: inline
In-Reply-To: <20250319-unbiased-rousing-finch-95ecdf@leitao>


--3kv7gh7vhshn6sce
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
MIME-Version: 1.0

On Wed, Mar 19, 2025 at 11:53:53AM -0700, Breno Leitao wrote:
> Hello Thierry,
>=20
> On Wed, Mar 19, 2025 at 07:26:52PM +0100, Thierry Reding wrote:
> > On Wed, Mar 19, 2025 at 03:09:57AM -0700, Breno Leitao wrote:
> > > Hello Arnd, Thierry, Jonathan, Sowjanya,
> > >=20
> > > On Tue, Mar 18, 2025 at 09:07:28PM +0100, Arnd Bergmann wrote:
> > > > On Tue, Mar 18, 2025, at 20:13, Mark Brown wrote:
> > > > > On Tue, Mar 18, 2025 at 08:00:05PM +0100, Arnd Bergmann wrote:
> > > > >
> > > > >> That does sound like the easiest answer: if the spi controller d=
river
> > > > >> knows that it needs a reset but there is no reset controller, sh=
utting
> > > > >> itself down and removing its child devices seems like the least
> > > > >> offensive action.
> > > > >
> > > > > In that case it's probably more just refuse to probe in the first=
 case
> > > > > without the reset controller.  Given that the device isn't workin=
g at
> > > > > all it seems like the hardware description is broken anyway...
> > > >=20
> > > > Right, I see now that it's doing a rather silly
> > > >=20
> > > >        if (device_reset(tqspi->dev) < 0)
> > > >                dev_warn_once(tqspi->dev, "device reset failed\n");
> > > >=20
> > > > after which it just continues instead of propagating returning
> > > > the error from the probe function.=20
> > >=20
> > > This would be another option, and I would be happy to update this pat=
ch
> > > with this suggestion.
> > >=20
> > > This patch was attempting to address the issue the other way around,
> > > where I was expecting that the reset methods are optional, thus
> > > marking the device_reset() function as optional.
> > >=20
> > > It appears that on certain UEFI machine types, the ACPI firmware does=
n't
> > > implement the _RST methods, and device_reset() will *always* fail. It=
's
> > > unclear whether this is due to a broken ACPI table or if it was
> > > intentionally designed this way.
> > >=20
> > > Tagging the driver maintainer (Thierry, Jonathan, Sowjanya) who might
> > > have a better understanding of the design in such cases.
> >=20
> > Can you specify what device this is and what software you've been
> > running (including firmware, L4T release, etc.)? I can try to find out
> > if this is a known issue, or if it's even intended to be this way.
>=20
> This is running on a NVIDIA Grace arm64 host.
>=20
> Here are a few details I collected, from ACPI tables and dmesg. If this
> is not enough, would you mind helping me to find how to get the data you
> are looking for?
>=20
> DSDT Table:
>=20
> 	* Original Table Header:
> 	*     Signature        "DSDT"
> 	*     Length           0x00001EC9 (7881)
> 	*     Revision         0x02
> 	*     Checksum         0x9B
> 	*     OEM ID           "NVIDIA"
> 	*     OEM Table ID     "TH500"
> 	*     OEM Revision     0x00000001 (1)
> 	*     Compiler ID      "INTL"
> 	*     Compiler Version 0x20220331 (539099953)
>=20
> 	....
> 		Device (QSP1)
> 		{
> 		Name (_HID, "NVDA1513")  // _HID: Hardware ID
> 		Name (_UID, 0x01)  // _UID: Unique ID
> 		Name (_CCA, 0x01)  // _CCA: Cache Coherency Attribute
> 		Name (_STA, 0x0F)  // _STA: Status
> 		Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
> 		{
> 			Memory32Fixed (ReadWrite,
> 			0x03250000,         // Address Base
> 			0x00010000,         // Address Length
> 			)
> 			Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
> 			{
> 			0x0000003A,
> 			}
> 		})
> 		Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> 		{
> 			ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties f=
or _DSD */,
> 			Package (0x01)
> 			{
> 			Package (0x02)
> 			{
> 				"spi-max-frequency",
> 				0x00989680
> 			}
> 			}
> 		})
> 		}
>=20
> dmesg:
>=20
> 	# dmesg | grep -i ACPI
> 	[    0.000000] efi: RTPROP=3D0x3c5409e398 ACPI 2.0=3D0x3c44c7b018 SMBIOS=
 3.0=3D0x3c54095618 TPMFinalLog=3D0x3c42c00000 MEMATTR=3D0x3c4d60b018 ESRT=
=3D0x3c4fa6fb98 TPMEventLog=3D0x3c42907018 RNG=3D0x3c44c7aa98 MEMRESERVE=3D=
0x3c42904e98
> 	[    0.000000] ACPI: Early table checksum verification disabled
> 	[    0.000000] ACPI: RSDP 0x0000003C44C7B018 000024 (v02 NVIDIA)
> 	[    0.000000] ACPI: XSDT 0x0000003C44C7B098 00012C (v01 NVIDIA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: FACP 0x0000003C44C7AD98 000114 (v06 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: DSDT 0x0000003C44C74018 001EC9 (v02 NVIDIA TH500   =
 00000001 INTL 20220331)
> 	[    0.000000] ACPI: FIDT 0x0000003C44C7BF18 00009C (v01 ALASKA A M I   =
 01072009 AMI  00010013)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C7BB18 00015E (v02 ALASKA PRMOPREG=
 00001000 INTL 20220331)
> 	[    0.000000] ACPI: SPMI 0x0000003C44C7BD98 000041 (v05 ALASKA A M I   =
 00000000 AMI. 00000000)
> 	[    0.000000] ACPI: FPDT 0x0000003C44C7BE18 000034 (v01 ALASKA T241c1  =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: PRMT 0x0000003C44C7BE98 00003C (v00 ALASKA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: SDEI 0x0000003C44C7A018 000024 (v01 NVIDIA A M I   =
 00000001 NVDA 00000001)
> 	[    0.000000] ACPI: HEST 0x0000003C44C78018 001054 (v01 NVIDIA A M I   =
 00000001 NVDA 00000001)
> 	[    0.000000] ACPI: BERT 0x0000003C44C7AF18 000030 (v01 NVIDIA A M I   =
 00000001 NVDA 00000001)
> 	[    0.000000] ACPI: EINJ 0x0000003C44C7AB18 000170 (v01 NVIDIA A M I   =
 00000001 NVDA 00000001)
> 	[    0.000000] ACPI: ERST 0x0000003C44C7A098 000290 (v01 NVIDIA A M I   =
 00000001 NVDA 00000001)
> 	[    0.000000] ACPI: GTDT 0x0000003C44C7A498 000084 (v03 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: APIC 0x0000003C44C76018 001778 (v06 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: PPTT 0x0000003C44C71018 0020F8 (v03 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C42BA9018 006CA7 (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SPCR 0x0000003C44C7AF98 000050 (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C7A998 0000CC (v02 NVIDIA A M I   =
 00000001 INTL 20220331)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C7A598 0000C0 (v02 NVIDIA TH500   =
 00000001 INTL 20220331)
> 	[    0.000000] ACPI: SSDT 0x0000003C42BA7018 00190C (v02 NVIDIA BPMP_S0 =
 00000001 INTL 20220331)
> 	[    0.000000] ACPI: MCFG 0x0000003C44C7A698 00007C (v01 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C70018 0003AE (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C70418 0003AE (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C44C70818 0003AF (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C42BA6018 0003AF (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SSDT 0x0000003C42BA6418 0003AF (v02 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: IORT 0x0000003C42BA5018 00072B (v06 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: APMT 0x0000003C42BA5E98 00013C (v00 ALASKA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: MPAM 0x0000003C42BA6E98 000084 (v01 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: SLIT 0x0000003C42BA6F98 00002D (v01 ALASKA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: SRAT 0x0000003C42BA6818 000574 (v03 NVIDIA A M I   =
 00000001 ARMH 00010000)
> 	[    0.000000] ACPI: HMAT 0x0000003C44C70E98 0000A6 (v02 ALASKA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: WSMT 0x0000003C44C70F98 000028 (v01 ALASKA A M I   =
 00000001 AMI  00000001)
> 	[    0.000000] ACPI: TPM2 0x0000003C44C7A918 00004C (v04 ALASKA A M I   =
 00000001 AMI  00000000)
> 	[    0.000000] ACPI: SPCR: console: pl011,mmio32,0xc280000,115200
> 	[    0.000000] ACPI: Use ACPI SPCR as default console: Yes
> 	[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x3c7fffffff]
> 	[    0.000000] psci: probing for conduit method from ACPI.
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x20000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x40000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x50000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x60000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x70000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x80000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x90000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xa0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xb0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0xe0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x100000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x110000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x120000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x130000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x140000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x150000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x160000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x170000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x180000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x190000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1a0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1c0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1d0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1e0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1f0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x200000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x210000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x220000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x230000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x240000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x250000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x260000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x270000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x280000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x290000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2a0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2b0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2c0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2d0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2e0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2f0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x300000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x310000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x320000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x330000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x340000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x350000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x360000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x370000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x380000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3a0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3b0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3c0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3d0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3e0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3f0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x400000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x410000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x420000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x430000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x440000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x460000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x480000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x490000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4a0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4b0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4c0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4d0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4e0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x4f0000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x500000 -> Node 0
> 	[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x510000 -> Node 0
> 	[    0.000320] ACPI: Core revision 20240827
> 	[    0.420784] ACPI: Added _OSI(Module Device)
> 	[    0.420785] ACPI: Added _OSI(Processor Device)
> 	[    0.420785] ACPI: Added _OSI(3.0 _SCP Extensions)
> 	[    0.420786] ACPI: Added _OSI(Processor Aggregator Device)
> 	[    0.421939] ACPI: 11 ACPI AML tables successfully acquired and loaded
> 	[    0.422284] ACPI: Interpreter enabled
> 	[    0.422286] ACPI: Using GIC for interrupt routing
> 	[    0.422296] ACPI: MCFG table detected, 5 entries
> 	[    0.422732] ACPI: IORT: SMMU-v3[11000000] Mapped to Proximity domain 0
> 	[    0.422746] ACPI: IORT: SMMU-v3[12000000] Mapped to Proximity domain 0
> 	[    0.422757] ACPI: IORT: SMMU-v3[15000000] Mapped to Proximity domain 0
> 	[    0.422767] ACPI: IORT: SMMU-v3[16000000] Mapped to Proximity domain 0
> 	[    0.422780] ACPI: IORT: SMMU-v3[5000000] Mapped to Proximity domain 0
> 	[    0.425981] ACPI: CPU0 has been hot-added
> 	[    0.426000] ACPI: CPU1 has been hot-added
> 	[    0.426017] ACPI: CPU2 has been hot-added
> 	[    0.426034] ACPI: CPU3 has been hot-added
> 	[    0.426050] ACPI: CPU4 has been hot-added
> 	[    0.426066] ACPI: CPU5 has been hot-added
> 	[    0.426083] ACPI: CPU6 has been hot-added
> 	[    0.426099] ACPI: CPU7 has been hot-added
> 	[    0.426117] ACPI: CPU8 has been hot-added
> 	[    0.426132] ACPI: CPU9 has been hot-added
> 	[    0.426149] ACPI: CPU10 has been hot-added
> 	[    0.426164] ACPI: CPU11 has been hot-added
> 	[    0.426181] ACPI: CPU12 has been hot-added
> 	[    0.426196] ACPI: CPU13 has been hot-added
> 	[    0.426212] ACPI: CPU14 has been hot-added
> 	[    0.426228] ACPI: CPU15 has been hot-added
> 	[    0.426245] ACPI: CPU16 has been hot-added
> 	[    0.426262] ACPI: CPU17 has been hot-added
> 	[    0.426278] ACPI: CPU18 has been hot-added
> 	[    0.426295] ACPI: CPU19 has been hot-added
> 	[    0.426310] ACPI: CPU20 has been hot-added
> 	[    0.426327] ACPI: CPU21 has been hot-added
> 	[    0.426342] ACPI: CPU22 has been hot-added
> 	[    0.426358] ACPI: CPU23 has been hot-added
> 	[    0.426374] ACPI: CPU24 has been hot-added
> 	[    0.426390] ACPI: CPU25 has been hot-added
> 	[    0.426406] ACPI: CPU26 has been hot-added
> 	[    0.426421] ACPI: CPU27 has been hot-added
> 	[    0.426438] ACPI: CPU28 has been hot-added
> 	[    0.426453] ACPI: CPU29 has been hot-added
> 	[    0.426470] ACPI: CPU30 has been hot-added
> 	[    0.426485] ACPI: CPU31 has been hot-added
> 	[    0.426502] ACPI: CPU32 has been hot-added
> 	[    0.426517] ACPI: CPU33 has been hot-added
> 	[    0.426533] ACPI: CPU34 has been hot-added
> 	[    0.426549] ACPI: CPU35 has been hot-added
> 	[    0.426571] ACPI: CPU36 has been hot-added
> 	[    0.426587] ACPI: CPU37 has been hot-added
> 	[    0.426602] ACPI: CPU38 has been hot-added
> 	[    0.426620] ACPI: CPU39 has been hot-added
> 	[    0.426640] ACPI: CPU40 has been hot-added
> 	[    0.426657] ACPI: CPU41 has been hot-added
> 	[    0.426672] ACPI: CPU42 has been hot-added
> 	[    0.426688] ACPI: CPU43 has been hot-added
> 	[    0.426706] ACPI: CPU44 has been hot-added
> 	[    0.426721] ACPI: CPU45 has been hot-added
> 	[    0.426737] ACPI: CPU46 has been hot-added
> 	[    0.426752] ACPI: CPU47 has been hot-added
> 	[    0.426769] ACPI: CPU48 has been hot-added
> 	[    0.426785] ACPI: CPU49 has been hot-added
> 	[    0.426802] ACPI: CPU50 has been hot-added
> 	[    0.426818] ACPI: CPU51 has been hot-added
> 	[    0.426834] ACPI: CPU52 has been hot-added
> 	[    0.426849] ACPI: CPU53 has been hot-added
> 	[    0.426865] ACPI: CPU54 has been hot-added
> 	[    0.426882] ACPI: CPU55 has been hot-added
> 	[    0.426898] ACPI: CPU56 has been hot-added
> 	[    0.426914] ACPI: CPU57 has been hot-added
> 	[    0.426929] ACPI: CPU58 has been hot-added
> 	[    0.426945] ACPI: CPU59 has been hot-added
> 	[    0.426961] ACPI: CPU60 has been hot-added
> 	[    0.426978] ACPI: CPU61 has been hot-added
> 	[    0.426994] ACPI: CPU62 has been hot-added
> 	[    0.427009] ACPI: CPU63 has been hot-added
> 	[    0.427025] ACPI: CPU64 has been hot-added
> 	[    0.427042] ACPI: CPU65 has been hot-added
> 	[    0.427058] ACPI: CPU66 has been hot-added
> 	[    0.427073] ACPI: CPU67 has been hot-added
> 	[    0.427090] ACPI: CPU68 has been hot-added
> 	[    0.427105] ACPI: CPU69 has been hot-added
> 	[    0.427121] ACPI: CPU70 has been hot-added
> 	[    0.427137] ACPI: CPU71 has been hot-added
> 	[    0.427213] ACPI: PCI Root Bridge [PCI2] (domain 0002 [bus 00-ff])
> 	[    0.427217] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI EDR HPX-Type3]
> 	[    0.427237] acpi PNP0A08:00: _OSC: platform does not support [PME AER=
 DPC]
> 	[    0.427257] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PCIeC=
apability LTR]
> 	[    0.427372] acpi PNP0A08:00: ECAM area [mem 0x610010000000-0x61001fff=
ffff] reserved by PNP0C02:01
> 	[    0.427383] acpi PNP0A08:00: ECAM at [mem 0x610010000000-0x61001fffff=
ff] for [bus 00-ff]
> 	[    0.427389] ACPI: Remapped I/O 0x0000610020000000 to [io  0x0000-0xff=
ff window]
> 	[    0.427887] ACPI: PCI Root Bridge [PCI3] (domain 0003 [bus 00-ff])
> 	[    0.427888] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI EDR HPX-Type3]
> 	[    0.427903] acpi PNP0A08:01: _OSC: platform does not support [PME AER=
 DPC]
> 	[    0.427921] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PCIeC=
apability LTR]
> 	[    0.428032] acpi PNP0A08:01: ECAM area [mem 0x618010000000-0x61801fff=
ffff] reserved by PNP0C02:02
> 	[    0.428039] acpi PNP0A08:01: ECAM at [mem 0x618010000000-0x61801fffff=
ff] for [bus 00-ff]
> 	[    0.428043] ACPI: Remapped I/O 0x0000618020000000 to [io  0x10000-0x1=
ffff window]
> 	[    0.428358] ACPI: PCI Root Bridge [PCI6] (domain 0006 [bus 00-ff])
> 	[    0.428359] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI EDR HPX-Type3]
> 	[    0.428370] acpi PNP0A08:02: _OSC: platform does not support [PME AER=
 DPC]
> 	[    0.428388] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PCIeC=
apability LTR]
> 	[    0.428498] acpi PNP0A08:02: ECAM area [mem 0x630010000000-0x63001fff=
ffff] reserved by PNP0C02:03
> 	[    0.428505] acpi PNP0A08:02: ECAM at [mem 0x630010000000-0x63001fffff=
ff] for [bus 00-ff]
> 	[    0.428508] ACPI: Remapped I/O 0x0000630020000000 to [io  0x20000-0x2=
ffff window]
> 	[    0.428907] ACPI: PCI Root Bridge [PCI7] (domain 0007 [bus 00-ff])
> 	[    0.428908] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI EDR HPX-Type3]
> 	[    0.428920] acpi PNP0A08:03: _OSC: platform does not support [PME AER=
 DPC]
> 	[    0.428937] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PCIeC=
apability LTR]
> 	[    0.429049] acpi PNP0A08:03: ECAM area [mem 0x640010000000-0x64001fff=
ffff] reserved by PNP0C02:04
> 	[    0.429054] acpi PNP0A08:03: ECAM at [mem 0x640010000000-0x64001fffff=
ff] for [bus 00-ff]
> 	[    0.429057] ACPI: Remapped I/O 0x0000640020000000 to [io  0x30000-0x3=
ffff window]
> 	[    0.429354] ACPI: PCI Root Bridge [PCI8] (domain 0008 [bus 00-ff])
> 	[    0.429355] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM C=
lockPM Segments MSI EDR HPX-Type3]
> 	[    0.429365] acpi PNP0A08:04: _OSC: platform does not support [PME AER=
 DPC]
> 	[    0.429382] acpi PNP0A08:04: _OSC: OS now controls [PCIeHotplug PCIeC=
apability LTR]
> 	[    0.429496] acpi PNP0A08:04: ECAM area [mem 0x650010000000-0x65001fff=
ffff] reserved by PNP0C02:05
> 	[    0.429501] acpi PNP0A08:04: ECAM at [mem 0x650010000000-0x65001fffff=
ff] for [bus 00-ff]
> 	[    0.429504] ACPI: Remapped I/O 0x0000650020000000 to [io  0x40000-0x4=
ffff window]
> 	[    0.431221] ACPI: bus type USB registered
> 	[    0.432569] pnp: PnP ACPI init
> 	[    0.432766] pnp: PnP ACPI: found 5 devices
> 	[    0.482111] ACPI: thermal: Thermal Zone [TZ00] (43 C)
> 	[    0.482392] ACPI: thermal: Thermal Zone [TZ01] (41 C)
> 	[    0.482663] ACPI: thermal: Thermal Zone [TZ02] (41 C)
> 	[    0.482937] ACPI: thermal: Thermal Zone [TZ03] (43 C)
> 	[    0.483204] ACPI: thermal: Thermal Zone [TZ04] (40 C)
> 	[    0.483473] ACPI: thermal: Thermal Zone [TZ05] (40 C)
> 	[    0.483740] ACPI: thermal: Thermal Zone [TZ06] (40 C)
> 	[    0.484007] ACPI: thermal: Thermal Zone [TZ07] (37 C)
> 	[    0.484272] ACPI: thermal: Thermal Zone [TZ08] (32 C)
> 	[    0.484558] ACPI: thermal: Thermal Zone [TZ09] (43 C)
> 	[    0.484825] ACPI: thermal: Thermal Zone [TZ0A] (31 C)
> 	[    0.485092] ACPI: thermal: Thermal Zone [TZ0B] (32 C)
> 	[    0.485139] ACPI: thermal: Thermal Zone [TZL0] (57 C)
> 	[    0.485257] ACPI GTDT: found 1 SBSA generic Watchdog(s).
> 	[    0.835253] power_meter ACPI000D:01: Found ACPI power meter.
> 	[    0.835269] power_meter ACPI000D:01: hwmon_device_register() is depre=
cated. Please convert the driver to use hwmon_device_register_with_info().
> 	[    0.835301] power_meter ACPI000D:02: Found ACPI power meter.
> 	[    0.835309] power_meter ACPI000D:02: hwmon_device_register() is depre=
cated. Please convert the driver to use hwmon_device_register_with_info().
> 	[    0.835325] power_meter ACPI000D:03: Found ACPI power meter.
> 	[    0.835332] power_meter ACPI000D:03: hwmon_device_register() is depre=
cated. Please convert the driver to use hwmon_device_register_with_info().
> 	[    1.667708] Modules linked in: spi_tegra210_quad acpi_power_meter loo=
p efivarfs autofs4
> 	[    2.451653] ACPI: bus type drm_connector registered
>=20
> Thanks for helping us here,

Can you maybe help clarify at what point you start seeing errors induced
by the recovery mechanism? Is this happening immediately on boot? Or
does something go wrong later down the line and then you start seeing
recovery issues? I wonder if there's an issue with hand-off from the
bootloader/firmware, or if there's a bug in the kernel that causes the
failure and subsequent error messages due to the missing _RST.

Thierry

--3kv7gh7vhshn6sce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmfdXkkACgkQ3SOs138+
s6ELzxAAvQtt2IVKjv4DHIGpwuHM+WEsg1l8Sw9rv9Zh+VteeD2QElkF8GHcm9DC
TDNzSLdSiPtVDO/iqKNOmnBWzMJv89F4j4m/eqqMg+oeIY0/upewZ4hxOq02gqzV
zNvFjQaHSqXoHr/bJFLsaTxUiEBS1Yov2vPL+9wc4RjWjM3nf+7+wASQzrb5f+sM
ohhIgEpP0k71mXb2hTThL2bCPkZAG3cMxerrL4NuHC3rsRz4ytR3RBC9hIYoavRZ
WIdKCj1C9KMYmD0KJ6AKVhQVb6pQhKxKr7dtrF8FJuhgkSrk1V5H5yMyJDwttcYe
DWeaf4tmxlY8QSwv6xMaWtAgEWVskBtjmZv9lZpnkTr+N+a2n8ZGT7lYW9zu3L67
r3D10PIO0mUVNkLjpCBBXQ1TWQVk1OtLlerDmuT0QeDQq+J1LeQpXVY6lxT8tsaO
MgRbO1s5DeRLFydrey0I6P3fc7jbtFhDFaAQuz4aNIWW8mdAPZCLmT5QviMPBeci
s9aHxEY2Hm/LRLd7WbkbUl2e1GygN5sl9otbhzy81UZwyh+8NeE9XV5Mw8LUitoI
a8uPRHMXs1P3cNIqZf77YbNTllfLEdXfYHfVqDrYOGP67JRFL6pRDRteCb85+szJ
bSGssJtI1jbwn6jG+B7eGv3PkKHFQtL6+j1LKQrTuQwJ5kyclbo=
=cPzK
-----END PGP SIGNATURE-----

--3kv7gh7vhshn6sce--

