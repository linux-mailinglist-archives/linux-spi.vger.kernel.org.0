Return-Path: <linux-spi+bounces-6153-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515879FB49A
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 20:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18118165ABE
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D91C4A34;
	Mon, 23 Dec 2024 19:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lb+mzfiK"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C71B87DD;
	Mon, 23 Dec 2024 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981303; cv=none; b=Io+JoRMKEggA//0VY5L3q0cglVWXNVEWgPdnr/V02iWWOoH+obs4x0di5G+rDAMWdFd05UPBBfCSBp6QBuL2OpNP7obbVZ2li5xQ0b3R+/tTUWGml4JGgPx8ewEeXDHZz5TT+LQ0ZhIbn6PMUGKbTLOFEscHI6N0X4WpnBDZHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981303; c=relaxed/simple;
	bh=U2OuHp4lYYEqziPyERTFGv6tmQUIwi6y4dJXQ7EdiOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YX6hfdb2Hw2yOGzCRZgQufdw9RmeSazUiAeQZsB5Mkei2qJ3BWvMHoj/FypBRr3654Xo1eXFZ12RnDH5Fjtt3TtKw2R19MPziAwDiOgbSOCxzmmlTaEuNkHQ2025ohf3+Sk8abb1A/gd9BcOBByNp7dN9OEeahq8iJ571anUIek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lb+mzfiK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1421C20003;
	Mon, 23 Dec 2024 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734981299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIeJWXZlfXZpFSIC+Ak+j2IOuvjq9EfINowGfwcIn9g=;
	b=Lb+mzfiKlKygiX60rPfm1+kW4cS17UC/FiL6RPAs7xgtZM7dRqNLtNP4f+z+vLPnU8UStE
	rvyPZ2C6ebwe8be1HRCJ9dduz7Kppxq4D+66mFvWDCxzkwwcnIS6Qg5CohEO+s/PqRLaB2
	n2KuVAP7e32xeShRm/U8OI0XiYQb7/RyvSHf4tMUsB4hwS17m4pZcVU/o2bg5ZsPYtVe4j
	OCF75MzC/Jv9feaPWPJX3ID1DwXmJxxjR2ggu8L54cB8Nq5LBLFNkZS09mwULTAKG7x660
	PtPqLx3AtQQk5/Z8MIQ0BNNDokBKgg7SMSOq0juxQR6F/SK4fnAVbSEb5dVujQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <broonie@kernel.org>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, <robh@kernel.org>,
  <krzk+dt@kernel.org>,  <conor+dt@kernel.org>,  <andersson@kernel.org>,
  <konradybcio@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <manivannan.sadhasivam@linaro.org>,  <linux-arm-msm@vger.kernel.org>,
  <linux-spi@vger.kernel.org>,  <devicetree@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <quic_srichara@quicinc.com>,  <quic_varada@quicinc.com>
Subject: Re: [PATCH v14 0/8] Add QPIC SPI NAND driver
In-Reply-To: <87mshe58gq.fsf@bootlin.com> (Miquel Raynal's message of "Mon, 02
	Dec 2024 17:57:09 +0100")
References: <20241120091507.1404368-1-quic_mdalam@quicinc.com>
	<87mshe58gq.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 23 Dec 2024 20:14:56 +0100
Message-ID: <87o712qki7.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Mark,

>> v14:
>>  * Updated commit message
>>  * Fix spelling mistake
>>  * Remove "inline" from multiple APIs from qcom_nandc.c file
>>  * Move '|' in qcom_param_page_type_exec() APIs at the end of line
>
> I guess it is now time to move on, I can apply patches 2-5 and share an
> immutable tag.

Do you want an immutable tag or will you wait the next cycle to apply
the spi patches?

Thanks,
Miqu=C3=A8l

> However, due to the frequent inconsistencies observed
> during the lifetime of this patchset, we might be slightly more
> conservative than usual and split the patches over two kernel
> releases. I fear there might be annoying fixes on the mtd side needed
> because of some side effects. Without these, the spi tree might have
> broken qcom support for several weeks. What do you think?
>
> Cheers,
> Miqu=C3=A8l

