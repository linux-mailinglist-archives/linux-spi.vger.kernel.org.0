Return-Path: <linux-spi+bounces-6159-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232FC9FC01E
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 17:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D0A163BDA
	for <lists+linux-spi@lfdr.de>; Tue, 24 Dec 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09241D90B9;
	Tue, 24 Dec 2024 16:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YeLVitDi"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787C1D79BE;
	Tue, 24 Dec 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735057307; cv=none; b=o65/6DgV3EF/jQUaS4CQ0q9EjIEv4g0yX0Fk4ReC8KO3mlBYMaoayUoylicM31c1SUzy7qbMLfNiom6rhfOpo49IcskVkTRq+QA5Pm7lR9asdZnnhrqcIvUqfjX/pBFvP+C3GgdfjWUyxhDfdAEQqZxdngJdWjnJ6b1TH+j+S5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735057307; c=relaxed/simple;
	bh=OpKW4Kf7nUPYr3aFtwfJuNa5sWRMoWD6UkpnZqMmuQs=;
	h=From:To:Cc:Cc:Subject:CC:Date:Message-ID:MIME-Version:
	 Content-Type; b=g+v7rJPvdp9EQat1qHgzzqc2KTrPEH6GhK8cZKfCX4wyh2F096v84oCAWXmYvE9lbOmf7qygAcbV0GcXoUe4EVpWR+taUqm01I8bzIt57XGbMfQl7FaNHgZO6PC7LIXQry8J0okSdZg5wajxBAGMRjT2TtCKeJQ6lvgbb56sf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=fail (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YeLVitDi reason="signature verification failed"; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 603FC1C0005;
	Tue, 24 Dec 2024 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1735057302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zacWYTH1KKoAoSFNbKaYi6ygHa5kvZSUGVZqJCenvWo=;
	b=YeLVitDiOw+2k4LyVJT5auwYUu2BPDNrFJ8oxYl8K7xRraob/t2nxU3JnRZF92VWClAKYB
	i+Jp06nbTsBRD4o0j7xqfJjpnAF2ZL7lDbDisVFpv1cnksqwvCRnvFS2fSRn7VJ86SmtDP
	DGZ/UT5CfgBvleFczcleM9kvUe89JOxOeOvEU4f0hi/Gp8OT66mSvrbF+oJnjr2B4u5ehC
	seR4hkGwH7aYa7tlGPss9RXhnbU0Idtg1XxHBscnYr+2EVdKFu0baTEeIddwxyhfshGXt0
	YxixKWYVIouM0wUBrZBQMzgHsXPqwhRdcr9OybO0VLimU0UldWaVWFj6Z28nhw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: <andersson@kernel.org>, <konradybcio@kernel.org>,
 <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
 <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Tudor Ambarus
 <Tudor.Ambarus@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, Frieder
 Schrempf <frieder.schrempf@kontron.de>, Michael Walle <michael@walle.cc>,
 Pratyush Yadav <pratyush@kernel.org>, linux-mtd@lists.infradead.org
Subject: [GIT PULL] mtd: topic branch for spi with Qcom changes
User-Agent: mu4e 1.12.7; emacs 29.4
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>
Date: Tue, 24 Dec 2024 17:20:38 +0100
Message-ID: <87jzbp9hnt.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mark,

I'm merging the Qcom series, in case you need a topic branch to apply
the spi bits (binding and driver), here it is.

Merry Christmas,
Miqu=C3=A8l

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/qcom=
-reorg-for-spi-6.14

for you to fetch changes up to 0c08080fd71cd5dd59643104b39d3c89d793ab3c:

  mtd: rawnand: qcom: use FIELD_PREP and GENMASK (2024-12-24 16:22:02 +0100)

----------------------------------------------------------------
Topic branch with preparation changes from Qcom in order to apply on top
the spi bits adding the Qcom SPI-NAND controller driver re-using a lot
of code that has been shared.

With this goal in mind, the raw NAND controller driver has been cleaned
up and reorganized, and only the relevant structures/helpers which have
nothing raw NAND specific should now be exported.

----------------------------------------------------------------
Md Sadre Alam (4):
      mtd: rawnand: qcom: cleanup qcom_nandc driver
      mtd: rawnand: qcom: Add qcom prefix to common api
      mtd: nand: Add qpic_common API file
      mtd: rawnand: qcom: use FIELD_PREP and GENMASK

 drivers/mtd/nand/Makefile            |    2 +-
 drivers/mtd/nand/qpic_common.c       |  759 ++++++++++++++++++
 drivers/mtd/nand/raw/qcom_nandc.c    | 1769 ++++++++----------------------=
------------
 include/linux/mtd/nand-qpic-common.h |  475 ++++++++++++
 4 files changed, 1561 insertions(+), 1444 deletions(-)
 create mode 100644 drivers/mtd/nand/qpic_common.c
 create mode 100644 include/linux/mtd/nand-qpic-common.h

