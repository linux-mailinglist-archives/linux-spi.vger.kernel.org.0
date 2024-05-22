Return-Path: <linux-spi+bounces-3001-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5F8CC38F
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 16:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508221C20EA5
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991FA1CAB3;
	Wed, 22 May 2024 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z378B23c"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0521AACB
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716389586; cv=none; b=OEBtRmBg5eWk6cHE6eqwelCNYcf3g24WLEKlQLq+Xy+PvphcBOl9p2nT7j09d3wpx01rRu4E0FCVtT/mDo7OBj9JhjUWb+cx7AGjKJX3ymMLlZDtiIAOYx8DcFnmpFIyR0gBYA8WaU4AuAqodNMB3Lih/PvaiDakQPjLWxnd9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716389586; c=relaxed/simple;
	bh=iTxDfmKuGA4VdpRY6e4zFRpbKNPvEmXZyOORSB16x0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SeQY9aWeBUC8DFH8T6Tg5tWnTIcSfwtc/c7XKFP5gVatpg4tqMzw4lV8kAly7eePuysWo8I+5qys7TuheloS6jcs/P7zFwcefCcSxvZ5YqwFc0Ss+V4NgPrF5ZYMoBdoIgNP6MlqDxhxceOb33INN40bCOu1N6XNc9qPkkk86fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z378B23c; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E595360005;
	Wed, 22 May 2024 14:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716389576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=80Ci0onUhPgbiDFJFnrSLztb4sb7lh0xu7cDWGZbpzA=;
	b=Z378B23cp6CxZ9g7nJkLPPpsT5dD85kUNvICnwEH2WpvBG+O1R5XCjbrrNSMDUzhFuWFrs
	Ha4Ar7F/DGqSUpMWz5vo7obe1z7b53p3DQAfMzJFAox3Mk6f30WIXI4GeeCiPA16rjkCKM
	57LqbWMPbmtQbYJjNqpKwzB7RmLrIuU4DwmkjuMcIPBvxdQraoOUrSexeFQF6YqnAZmfEa
	UABPkE05tQrt4IRNRBjq6OMkd2K/PBWQ/A9dT+KrA+K49e0nmlJCtHwmTW1eMrKVmg6QUO
	y4xGeKfhCGzoZVXHIZsy8nTGc4+nuz1wZ3yp6rRVtRuQltavN/W6NmIFM7g4gA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	j.neuschaefer@gmx.net,
	Julien Su <juliensu@mxic.com.tw>,
	Alvin Zhou <alvinzhou@mxic.com.tw>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/4] spi: differentiate between unsupported and invalid requests
Date: Wed, 22 May 2024 16:52:51 +0200
Message-Id: <20240522145255.995778-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Mark,

I am working on spi-nand continuous read support, which lead me to check
what spi controllers were capable of.

From a caller (and reviewer) point of view, distinguishing between error
cases has been proven useful, especially between two conditions:
- the request is totally unsupported and will never work
- the request is typically out of range somehow but a subsequent call
  with corrected parameters might work

So while I was statically reading the various drivers, I attempted to
clarify these situations and thought it might be nice to have this
upstream as well.

As ENOTSUPP is not a SUSV4 code and previous series have already been
merged to reduce its use, I also converted these few cases to EOPNOTSUP
instead, but if anybody doesn't like these changes, it can be dropped.

The series can be squashed if you prefer, I don't mind.

Cheers,
Miquèl

Miquel Raynal (4):
  spi: dw: differentiate between unsupported and invalid requests
  spi: mxic: differentiate between unsupported and invalid requests
  spi: rpc-if: differentiate between unsupported and invalid requests
  spi: wpcm-fiu: differentiate between unsupported and invalid requests

 drivers/spi/spi-dw-bt1.c   | 10 ++++++----
 drivers/spi/spi-mxic.c     |  2 +-
 drivers/spi/spi-rpc-if.c   | 12 ++++++------
 drivers/spi/spi-wpcm-fiu.c |  6 +++---
 4 files changed, 16 insertions(+), 14 deletions(-)

-- 
2.40.1


