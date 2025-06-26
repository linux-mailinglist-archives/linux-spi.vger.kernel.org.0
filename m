Return-Path: <linux-spi+bounces-8779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E70AE96B5
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 09:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91C77AFF9E
	for <lists+linux-spi@lfdr.de>; Thu, 26 Jun 2025 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B723B619;
	Thu, 26 Jun 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tf9KD+6H"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0077B23B60E;
	Thu, 26 Jun 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922759; cv=none; b=RonrqPsCJNSvD1EjFC5LT2ieIEg3FpUDlXLHP+NYpkob7PJ4jS1T+IQ+X0YbaBRoBixy2UO438tUsVW1pT1tmmQ0GWV747X29rNu90buTtQN+5BBWfvNIXeoa6IO3WzeNLR4AbXakUmkUjYIZIwdYpNwntrhRsokuU2GwrSm8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922759; c=relaxed/simple;
	bh=cP+LS+JT48xAm+OMUAjyBYcTGTWWmH6uA1TAjVp0oik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZYdXmdNTj24BYwkotJIA8BY/+XSCjSVhUeTf01oqRCNmjOSWk1C+jCXTjfpvgNHt26r3xb3Rz4/Q55Fq4r50ZYkRYlx6ZHVLPMfdNkSCaOqt2GdNDZXJRJUp13T1x3iLZPgGb0WhE2jyFk21vgUW9AlNMKy8EYxlyVHVx3m9CSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tf9KD+6H; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6541044A0C;
	Thu, 26 Jun 2025 07:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750922755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cP+LS+JT48xAm+OMUAjyBYcTGTWWmH6uA1TAjVp0oik=;
	b=Tf9KD+6HR5QRq1KpbRFlU6OXd/2oZFt2nMpY3dRF2jQlBntgE/uXldQe4ASkyQuEFeGFpU
	x54Kx+uyFahHqD3gLmlKtEeKISIFQ3cFUyziK87YXTImfrxfbju0VCXhTsvDnQf8BdN7O8
	G+zSkknpujMQcnwoCAGu3wP0+pY75y1JNixyG/vHrgLA+Xz2GjaglsXBYqN65JcNmkJ2IG
	CHr/pRPQ8jqPg5GqRIOY8ZPudj3lLBUSn3TIOdglIrwN8v5Vv1JujssPROvaReJZsZkxOD
	dkBbPLZ+LpAu3fgJ86CilDjP0TbjiVkr+5k4q4FmlPID1oN06B+OH98gZbKc7w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Gabor Juhos <j4g8y7@gmail.com>,  Md Sadre Alam
 <quic_mdalam@quicinc.com>,  Varadarajan Narayanan
 <quic_varada@quicinc.com>,  Sricharan Ramabadhran
 <quic_srichara@quicinc.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  linux-spi@vger.kernel.org,
  linux-mtd@lists.infradead.org,  linux-arm-msm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Lakshmi Sowjanya D
 <quic_laksd@quicinc.com>
Subject: Re: [PATCH v3 0/2] spi: spi-qpic-snand: avoid memory corruption
In-Reply-To: <aFx7ix0uikB8dkm4@finisterre.sirena.org.uk> (Mark Brown's message
	of "Wed, 25 Jun 2025 23:43:23 +0100")
References: <20250618-qpic-snand-avoid-mem-corruption-v3-0-319c71296cda@gmail.com>
	<aFx7ix0uikB8dkm4@finisterre.sirena.org.uk>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 26 Jun 2025 09:25:53 +0200
Message-ID: <8734bnx8u6.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvhedtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhegghekhiejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepqhhuihgtpghmuggrlhgrmhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehquhhitggpvhgrrhgruggrsehquhhitghinhgtrdgtohhmpdhrtghpthhtohepqhhuihgtpghsrhhitghhrghrrgesqhhuihgtihhntgdrtghomhdprhgtphhtt
 hhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrgh

Hi Mark,

On 25/06/2025 at 23:43:23 +01, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jun 18, 2025 at 10:22:48PM +0200, Gabor Juhos wrote:
>> The 'spi-qpic-nand' driver may cause memory corruption under some
>> circumstances. The first patch in the series changes the driver to
>> avoid that, whereas the second adds some sanity checks to the common
>> QPIC code in order to make detecting such errors easier in the future.
>>=20
>> Preferably, the two patches should go along in via the SPI tree.
>> It is not a strict requirement though, in the case the second patch
>> gets included separately through the MTD tree it reveals the bug
>> which is fixed in the first patch.
>
> Miquel, are you OK with this plan for merging via the SPI tree?

Absolutely, my Ack is already there, thanks for asking.

Miqu=C3=A8l

