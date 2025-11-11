Return-Path: <linux-spi+bounces-11152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD425C4B21A
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 03:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4B78934B9F2
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AC234164B;
	Tue, 11 Nov 2025 02:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="EzIaskis"
X-Original-To: linux-spi@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F47260B;
	Tue, 11 Nov 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762826470; cv=none; b=jHgymVC5Qg9Afaa7bNjQa7TQaVRwxuU+b7tHMM75qzCYynWqcceTj9nHZ1XDzCrYxf7SKuPPL3KnuopHD77IKaakg3ljbiuVNZiD/mPj5jygfYyy+yPMWTIA+HhWndlBVI7Q9HAIxlx8oLPuY0SMPahUFCvPBfgUQNaWGnbWr9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762826470; c=relaxed/simple;
	bh=fa86p+TM+I3rIDtTcPPW3kZF6C0iOy8eWSbTa7XiI7g=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jNmBeLqVZKORr/L3KcXhRLWqOwMM7kVLXuFWyjZFMkFSzH5mbwLfs8DMIwmQNxapjAsLtNHa0NHIvr1A2wrD99FGqIfAUhsnR66oLs//9m1438tDZe0Lgf/2nc1olNxlmH6aVcEO8LiLGnRZcT8bfBBSl+FdI3qRqOmxKOOXiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=EzIaskis; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YvwXEA8Gn372z7HVORmMtVsV2QhDOhzv2XItjziiVSY=;
	b=EzIaskisNXvzFqIBBoLUHXS2svTWm/cVDOj3fE7GR5HeJB3eZ6yCUda5yKcTXMxh/GI8uDoXF
	jMw6o7sv4B2bfotTq9rMj33kYloFNrDQDN2nt/j6K0RVscXrFBWl4/oNVDin+IPjFQqf+s3vYrY
	/KwEU552LeHqQnVArFexfRA=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d58q10HkMz1cyVl;
	Tue, 11 Nov 2025 09:59:25 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 18AFF1800CE;
	Tue, 11 Nov 2025 10:01:04 +0800 (CST)
Received: from kwepemn500012.china.huawei.com (7.202.194.153) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 10:01:03 +0800
Received: from kwepemn200006.china.huawei.com (7.202.194.129) by
 kwepemn500012.china.huawei.com (7.202.194.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 10:01:03 +0800
Received: from kwepemn200006.china.huawei.com ([7.202.194.129]) by
 kwepemn200006.china.huawei.com ([7.202.194.129]) with mapi id 15.02.1544.011;
 Tue, 11 Nov 2025 10:01:03 +0800
From: liudingyuan <liudingyuan@h-partners.com>
To: "shenyang (M)" <shenyang39@huawei.com>, "broonie@kernel.org"
	<broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, Kangfenglong
	<kangfenglong@huawei.com>, liuyonglong <liuyonglong@huawei.com>, "lujunhua
 (E)" <lujunhua7@h-partners.com>, "yubowen (H)" <yubowen8@huawei.com>
Subject: re: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in
 hisi_spi debugfs initialization
Thread-Topic: [PATCH] spi: hisi-kunpeng: Fixed the wrong debugfs node name in
 hisi_spi debugfs initialization
Thread-Index: AdxSrhaAyut68gfvQZC0fw3MSAKiDA==
Date: Tue, 11 Nov 2025 02:01:03 +0000
Message-ID: <fc10632d875346eead8bf488c56b6bbc@h-partners.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> In hisi_spi_debugfs_init, spi controller pointer is calculated by contain=
er_of macro, and the member is hs->dev. But the host pointer cannot be calc=
ulated offset directly by this, because hs->dev points to the device in pla=
tform device(pdev->dev), and it is > the host->dev.parent points to the pde=
v->dev, which is set in __spi_alloc_controller.
>
>In this patch, this issues is fixed by getting the spi_controller data fro=
m pdev->dev->driver_data directly, driver_data points to the spi controller=
 data in the probe stage.
>
> Signed-off-by: Devyn Liu <liudingyuan@h-partners.com>
> ---
>  drivers/spi/spi-hisi-kunpeng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-hisi-kunpeng.c b/drivers/spi/spi-hisi-kunpen=
g.c index dadf558dd9c0..7458a4bc0856 100644
>--- a/drivers/spi/spi-hisi-kunpeng.c
> +++ b/drivers/spi/spi-hisi-kunpeng.c
> @@ -164,7 +164,7 @@ static int hisi_spi_debugfs_init(struct hisi_spi *hs)
> =20
>	struct spi_controller *host;
> =20
> -	host =3D container_of(hs->dev, struct spi_controller, dev);
> +	host =3D hs->dev->driver_data;
>  	snprintf(name, 32, "hisi_spi%d", host->bus_num);
>  	hs->debugfs =3D debugfs_create_dir(name, NULL);
>  	if (IS_ERR(hs->debugfs))
> --
> 2.33.0

Gentle ping on this patch.

