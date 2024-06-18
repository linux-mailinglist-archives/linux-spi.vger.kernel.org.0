Return-Path: <linux-spi+bounces-3442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 761B990D9BD
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B61C1F25046
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A96013F003;
	Tue, 18 Jun 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TZMgdO29"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C696D14C5A3;
	Tue, 18 Jun 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729109; cv=none; b=gf3md/1g2YhxM7Am7/N/QLtgQhMKt1qT0BeBcIDgOASlMe+cfqiNCsivKQyh/WnA619ECYedJDcPLC7UhHPU6EsC6ilhko3eUcFuE165L4WkzT59rSlPco3+ZYqaesCiEjn5ml7aCCzMa68JpIdx/0C/N/FMvi56D1/yKpJgaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729109; c=relaxed/simple;
	bh=0Kx0EQ3cQ47Egstu5KMjBtikDuLK960QIiwAMaXxIXQ=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CUIgoSeN/RbfNlt1zQ130WSYY7apMyFde8Bc893uwyKwaGmJN7bZDlQX4i9kWsmE9R7pXBmy+qiPNW9Uoj70aPjkjnLFhndxeWVvj/RFO5mW0biJSFwiFn7tozu+Oc8tRM6LsmbvTUbDorlWgxnhb19Zwp13S1WTce9w7bBg/Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TZMgdO29; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I5c7kM027173;
	Tue, 18 Jun 2024 11:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=0Kx0EQ3cQ47Egstu5KMjBtikDuLK960QIiwAMaXxIXQ=; b=
	TZMgdO29TlKp72WLpzK1L9V0dNnjpOomy/WdkG3AykhEaTy2wxXpmQxP/NPldyxy
	svvJkVag9Ln4NIub00L7VL0TTaHsMYtTCQOduD+A8cnMMc6B2FHcNIXx7u5+vYmy
	jS198qB4BdE7qae7eBqjfQSsWJDS/bWXA7cGS/SqiWD9Lu9gEzJumqZz9EJTsVMV
	YMAPi4MmjI1SlfuLG7/msH0xO9dCEELboxd1SRqW1RcoEf7j1Y4Kr8M0R734IQnq
	TbX7lA0otQp7zo6nvEEljwrrFHio7pVwCfWSbASo8bN0eglSXDTbYYcN9d2AzJUH
	i8PpI+7Ogv0+0MIgerIr6g==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ys7cjufb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 11:44:52 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Jun
 2024 17:44:51 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 18 Jun 2024 17:44:51 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.31])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CB91D820248;
	Tue, 18 Jun 2024 16:44:50 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Mark Brown' <broonie@kernel.org>,
        'Charles Keepax'
	<ckeepax@opensource.cirrus.com>
CC: <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240611132556.1557075-1-ckeepax@opensource.cirrus.com> <20240611132556.1557075-2-ckeepax@opensource.cirrus.com> <3bcb0b44-8885-40f9-938d-07b44116f3bf@sirena.org.uk>
In-Reply-To: <3bcb0b44-8885-40f9-938d-07b44116f3bf@sirena.org.uk>
Subject: RE: [PATCH 2/3] spi: cs42l43: Add speaker id support to the bridge configuration
Date: Tue, 18 Jun 2024 17:44:50 +0100
Message-ID: <00dd01dac19e$d6a6cc60$83f46520$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQEWl5wsLc1/leMvWEC0YoAstNYIZAJvriGDAZjXGrSzNcj8AA==
X-Proofpoint-GUID: Cbt0IDAhyB9d-n5AMCIfrtIFbjnd2vSa
X-Proofpoint-ORIG-GUID: Cbt0IDAhyB9d-n5AMCIfrtIFbjnd2vSa
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 18, 2024 at 5:06=E2=80=AFPM Mark Brown wrote:
> On Tue, Jun 11, 2024 at 02:25:55PM +0100, Charles Keepax wrote:
> > From: Simon Trimmer <simont@opensource.cirrus.com>
> >
> > OEMs can connect a number of types of speakers to the sidecar =
cs35l56
> > amplifiers and a different speaker requires a different firmware
> > configuration.
>=20
> This doesn't apply against current code, please check and resend.

I'll catchup with Charles about this tomorrow (hopefully) - the snag =
seems to be that an ancestor has been taken for integration via the =
linux-spi tree

https://lore.kernel.org/all/171778072618.80456.1164637774989487170.b4-ty@=
kernel.org/

-Simon


