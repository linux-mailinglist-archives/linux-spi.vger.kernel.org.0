Return-Path: <linux-spi+bounces-12119-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A279CDB1E5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Dec 2025 02:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029A830213FC
	for <lists+linux-spi@lfdr.de>; Wed, 24 Dec 2025 01:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A87287246;
	Wed, 24 Dec 2025 01:59:46 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E12285CB6;
	Wed, 24 Dec 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766541586; cv=none; b=IKiJ2DSGXD5D5ZOQ1L3wNFgnTVRzvfDOpzxcQ0P8ryzrFmpO0DfEJAG7zLPBmPdJ2s0WW8sx3HIvOi1NWEw67/1NaoAmRrZVAXTW3QXa6QzwScD9uneCeSgFJwjGYovkLlcZ/EFolOuzepox1kAkqQQNiVc8nNrSjJvkdLyq+Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766541586; c=relaxed/simple;
	bh=bP6OzLvDhPIw8UzwOyVhjy9qPXvncOlFG/g8rgc0Xxc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=bRl0B+qjGi8TVyVcoy3gArSempr/V0wm4yyRxxZ0flfbQaqbAq6npNLQ0CnjY144xp5TSWSwI+4BVhufZ0rwcvFtdf9Dol2WlPDGmhw6x+hsyahskD2ctbp9DtLWT/nRiPMP2gY5iYMCG4YwfDSOobrE9IBr+8jCW0Vyv5n4kTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1766541573t010t35411
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.96.96])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12084601525523118900
To: "'Danilo Krummrich'" <dakr@kernel.org>
Cc: "'Bartosz Golaszewski'" <brgl@kernel.org>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>,
	"'Bartosz Golaszewski'" <brgl@kernel.org>,
	"'Bartosz Golaszewski'" <bartosz.golaszewski@linaro.org>,
	<andriy.shevchenko@linux.intel.com>,
	<andy@kernel.org>,
	<broonie@kernel.org>,
	<ckeepax@opensource.cirrus.com>,
	<david.rhodes@cirrus.com>,
	<djrscally@gmail.com>,
	<gregkh@linuxfoundation.org>,
	<heikki.krogerus@linux.intel.com>,
	<krzk@kernel.org>,
	<linus.walleij@linaro.org>,
	<linux-acpi@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>,
	<mstrozek@opensource.cirrus.com>,
	<p.zabel@pengutronix.de>,
	<patches@opensource.cirrus.com>,
	<rafael@kernel.org>,
	<rf@opensource.cirrus.com>,
	<sakari.ailus@linux.intel.com>
References: <02fd01dc73df$3b641bf0$b22c53d0$@trustnetic.com> <CAMRc=Mf2A++CHYcMdBi0bQ0DOAGLaSatQEOmu=aAEG_YjCqEWg@mail.gmail.com> <030001dc73e8$56e38330$04aa8990$@trustnetic.com> <CAMRc=Meugd9tEDefPnYHidDMTdCP+8fptVXNvqjSi1tjXPuVRA@mail.gmail.com> <030101dc73f1$46a62b40$d3f281c0$@trustnetic.com> <DF5J7H0BSBTK.362ZAJTRBK6U1@kernel.org>
In-Reply-To: <DF5J7H0BSBTK.362ZAJTRBK6U1@kernel.org>
Subject: RE: [PATCH v7 3/9] software node: allow referencing firmware nodes
Date: Wed, 24 Dec 2025 09:59:32 +0800
Message-ID: <031401dc7478$f2246040$d66d20c0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQIzaRfJPMiwz9071uYI3gJ0t6u2qwFWX8iGAiY76pIB9a+LsAJlPnfRAfA44Bm0M9/nYA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M//muKyjQOU4LZpHac2tuoQLK7s9sl0rzCnwrd3FdjlvJHwJzl53pBpS
	w6yhlldtqXViC71TMWuwapuWGHoNpyQ14BLToaqKBzRDYYfAu39JmwHFvN6LFWQ+ng7cfq4
	jOha1tvZp5tZFW0uDVgGfb1ciymolOUovtKpeNALxp2Qy08Biw3Kjv9bsNnblR+h5Hertix
	ShYNTUAKsFjkHP/vT3YTGnC7/EVaxGc20hi5j/SjgAvE6od0ljs7Of0ujp9rzYHSFASf9li
	kWMmUUBhZHYCmfUzqF8NRieE+Su0WdXQwuyYN247hJQ5pIoYsDYag/wh3fdBX2aEXyU44wc
	pwN+grtrwbx0HqWt0tQTKqU/ck+BOgRKGYd+oNolFryARk38Z3KYH1z5vpTrR6RayC8qhFF
	YOXJJ+A4vnhr8vUIkOZCaUJKfzio9kvCBHSgoF42zBeP6O/ZoMlRr09Z/0xFjg2WkxCi1TX
	950w57ApKpGFaQxqAoFLybDQ4LhjxJE1a9WbcWcze6XY2Bzv6fKxMM6ka6I3eTEJ4DLPA2b
	/QLBhVG9W9kZFoos6hXIjWV8sbTavZfkdvizgenEPbH7/UreydV8PSzsLr+XCB/xBmly32Y
	soR3i69XvyfGQwWo5Q+85d/pe1zVI5JLmUPxVPtuhxd9kpaaKD3AjNpn90aLUs5GiY0z3pD
	+8zvsp31Tp+NO4CE1ZIhCNePauFOM7fuwyvSm9U6t7D6dDLuoJSt+DQkMemUmekeJOanWNe
	mmqXjt0NOQW3kvpvJMz8z744PrOPNXHpgSeKApxI+zSiott1td6hNwSql14/v9dwwW7HH3o
	08Q91HAhENnGOUziLOqVhVubQ1490GYRf5Vi+4SFuwjmPec25pUS1vdw4ZvED63tVYMfNlP
	9R2QJUrB5S1/AxRM/pFgu/Z0b3ZbZOAW94gwM0ZENT0OE4Vxu/S60dORe9qSFUjO+e3RfcT
	TH+aUYapAvWpcC2Pw1iT+m0R/wAJknc2491gbcwDqTMH2kzzqU/GY8wZWNG3HE7YhFAEQyC
	f5Lh0kul5VtgDVchvl1UCFm36Nq3F8u9sYbOMWoQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On Tue, Dec 23, 2025 6:42 PM, Danilo Krummrich wrote:
> On Tue Dec 23, 2025 at 10:48 AM CET, Jiawen Wu wrote:
> > On Tue, Dec 23, 2025 5:37 PM, Bartosz Golaszewski wrote:
> >> On Tue, Dec 23, 2025 at 9:44=E2=80=AFAM Jiawen Wu =
<jiawenwu@trustnetic.com> wrote:
> >> > And I temporarily added this line to fix it:
> >> >
> >> > diff --git a/include/linux/property.h b/include/linux/property.h
> >> > index 272bfbdea7bf..e30ef23a9af3 100644
> >> > --- a/include/linux/property.h
> >> > +++ b/include/linux/property.h
> >> > @@ -371,6 +371,7 @@ struct software_node_ref_args {
> >> >  (const struct software_node_ref_args) {                          =
      \
> >> >         .swnode =3D _Generic(_ref_,                               =
\
> >> >                            const struct software_node *: _ref_, \
> >> > +                          struct software_node *: _ref_,       \
> >> >                            default: NULL),                      \
> >> >         .fwnode =3D _Generic(_ref_,                               =
\
> >> >                            struct fwnode_handle *: _ref_,       \
> >> >
> >>
> >> Ah I see, we'd assign struct software_node * to const struct
> >> software_node * and it used to work but with _Generic() we need the
> >> exact type. I agree with this approach, do you want to send a =
proper
> >> patch?
> >
> > It might be more appropriate for you to send the patch, and could =
also
> > check if there are any other missed details, like for fwnode...
> > I'm not very proficient in this field. :)
>=20
> There is already [1], which I queued up in the driver-core tree to =
send as fix
> for -rc3.
>=20
> [1] =
https://lore.kernel.org/lkml/20251219083638.2454138-1-sakari.ailus@linux.=
intel.com/

I apologize for not noticing this patch... I did something superfluous.



