Return-Path: <linux-spi+bounces-12087-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26CCD8F4B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 11:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE68930B6D0B
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACFC1B4F0A;
	Tue, 23 Dec 2025 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB9Gi0xH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F41315D3E;
	Tue, 23 Dec 2025 10:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766486520; cv=none; b=Flct4cLCdURbg07kAxhl2uOx1R/RUCvk33P45GHt3Z5RT7gZimLRM4CRefCteCzKqxdmodtPlJ894wTqEqzSaCweP2zgugLsICWiQyCvCfMC9JSq2Z2Z+j9s9Tgx9kJBbRhKU40H8nfYw+fQNuDHApOyateCX7QN+QwubxY6EtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766486520; c=relaxed/simple;
	bh=UFw3iIBjIOQhDLXO7EWczIafIBrzpn1pV/Yc2YaQ6Rs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=ZE/v6AdLiwEHD3vui/NovcjOJz4g++p0acdAQWWQWgXpPBKMFft9SLUJWb639FtgryZzR2D4r16YDNyN/ekqP5QSo3/UO1Z0MGsrkwZj680t0h9aeyxIxmRN1GO5SsjF8ZdPhbhKr9Am3Bjs/jRtwTrsbXAzhQSwVWvqw8h/e30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB9Gi0xH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD325C113D0;
	Tue, 23 Dec 2025 10:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766486519;
	bh=UFw3iIBjIOQhDLXO7EWczIafIBrzpn1pV/Yc2YaQ6Rs=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=bB9Gi0xH+Xstu+d5D3qkSvWf/MUNfAXsJcn2rD7o/ZTbUNdYIZZLYXOaSgMbqZFSB
	 kOP4uO/cbfu+RhxgUbDUsG7rfpkKG60bPoJg8nHF0N6+504HLM2L6ebCF+cMehQl68
	 QreicZhaSonuMnCL+ZadqXii0AG9//fztuqbcnUQq2PtIPtacx4sXMOSBAXNs6wvKR
	 z0u9Dnx7xoJ7k8udqSPzt+1XHRCZqWkHN2PcuILSb4WL9vQ8Z/CpkAQx4USmsFN0M/
	 jCL6oqXmSupgKj7+4MGECsd4hwlwo+EuQb5+chk1IJQhIpaK+LSUCZhRYVMaSHKKHO
	 w/v8zKYPH5HVg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Dec 2025 11:41:52 +0100
Message-Id: <DF5J7H0BSBTK.362ZAJTRBK6U1@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 3/9] software node: allow referencing firmware nodes
Cc: "'Bartosz Golaszewski'" <brgl@kernel.org>, "'Bartosz Golaszewski'"
 <bartosz.golaszewski@linaro.org>, <andriy.shevchenko@linux.intel.com>,
 <andy@kernel.org>, <broonie@kernel.org>, <ckeepax@opensource.cirrus.com>,
 <david.rhodes@cirrus.com>, <djrscally@gmail.com>,
 <gregkh@linuxfoundation.org>, <heikki.krogerus@linux.intel.com>,
 <krzk@kernel.org>, <linus.walleij@linaro.org>,
 <linux-acpi@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <mstrozek@opensource.cirrus.com>,
 <p.zabel@pengutronix.de>, <patches@opensource.cirrus.com>,
 <rafael@kernel.org>, <rf@opensource.cirrus.com>,
 <sakari.ailus@linux.intel.com>
To: "Jiawen Wu" <jiawenwu@trustnetic.com>
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com>
 <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com>
 <030001dc73e8$56e38330$04aa8990$@trustnetic.com>
 <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com>
 <030101dc73f1$46a62b40$d3f281c0$@trustnetic.com>
In-Reply-To: <030101dc73f1$46a62b40$d3f281c0$@trustnetic.com>

On Tue Dec 23, 2025 at 10:48 AM CET, Jiawen Wu wrote:
> On Tue, Dec 23, 2025 5:37 PM, Bartosz Golaszewski wrote:
>> On Tue, Dec 23, 2025 at 9:44=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.c=
om> wrote:
>> > And I temporarily added this line to fix it:
>> >
>> > diff --git a/include/linux/property.h b/include/linux/property.h
>> > index 272bfbdea7bf..e30ef23a9af3 100644
>> > --- a/include/linux/property.h
>> > +++ b/include/linux/property.h
>> > @@ -371,6 +371,7 @@ struct software_node_ref_args {
>> >  (const struct software_node_ref_args) {                              =
  \
>> >         .swnode =3D _Generic(_ref_,                               \
>> >                            const struct software_node *: _ref_, \
>> > +                          struct software_node *: _ref_,       \
>> >                            default: NULL),                      \
>> >         .fwnode =3D _Generic(_ref_,                               \
>> >                            struct fwnode_handle *: _ref_,       \
>> >
>>=20
>> Ah I see, we'd assign struct software_node * to const struct
>> software_node * and it used to work but with _Generic() we need the
>> exact type. I agree with this approach, do you want to send a proper
>> patch?
>
> It might be more appropriate for you to send the patch, and could also
> check if there are any other missed details, like for fwnode...
> I'm not very proficient in this field. :)

There is already [1], which I queued up in the driver-core tree to send as =
fix
for -rc3.

[1] https://lore.kernel.org/lkml/20251219083638.2454138-1-sakari.ailus@linu=
x.intel.com/

