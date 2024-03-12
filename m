Return-Path: <linux-spi+bounces-1768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3E88792DE
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 12:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FA4DB20933
	for <lists+linux-spi@lfdr.de>; Tue, 12 Mar 2024 11:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA35C79B69;
	Tue, 12 Mar 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="TrUkrTR/"
X-Original-To: linux-spi@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853779B76
	for <linux-spi@vger.kernel.org>; Tue, 12 Mar 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242463; cv=none; b=Aow2liU4+DHsJznE/fWtYIDE5OCTZXuCbxV7Yzhhd1Td8vV8LiP9nXC+e7trjUXDDcC4vWHXC5CRDwdOTCZp7pX0zsDopJjPZc6xtNiSSFouYQFaZ+nO1l6tEhEDtSOShdbtRBvmPAXC35RVf5MGPcHzsBTpwzYvcOnaCzsCxrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242463; c=relaxed/simple;
	bh=fhdWz0hmvT6JHoiSsg/5aNMHMv+zNXCzl2RiBe1VEbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NgWjGltExqsWDqKnXKdev3EBelRcTVXon8CpXoM77M6poCjW3JDGXfb4dNG3XmqvVag/rWIcWdIE1Zx8DvHKOARxOLooQG2quT4PW0kZiQ/3JOsWH3TgeRVDxAvU3uq/kmmCbzm0JMx1Gj/rH/O3l66SkiD4z+wJNFqC0vM7iP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=TrUkrTR/; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202403121120537d119912f19863bdef
        for <linux-spi@vger.kernel.org>;
        Tue, 12 Mar 2024 12:20:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FO0aKLJT/IqBPuS8NvAJzOa1erXtvJLjkCpu/sP9Hr4=;
 b=TrUkrTR/dQYzQ0465OGiuAuh1ifW3WB38kwHix8cDUie1ewTvwY5G0bqPC9uq4e9JS2dfD
 7I8/FOUmy7eRp9Pi3u1TdNJyNYnf1I6/ZJINc6vLpvPVeeIl21siq2N+VWX9b71VYuj0yvyF
 cncKY6dLy15mx8IKu2NnRbOuEQCTw=;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-spi@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Mark Brown <broonie@kernel.org>,
	Fugang Duan <B38611@freescale.com>,
	Gao Pan <pandy.gao@nxp.com>
Subject: [PATCH] spi: lpspi: Avoid potential use-after-free in probe()
Date: Tue, 12 Mar 2024 12:20:48 +0100
Message-ID: <20240312112050.2503643-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

fsl_lpspi_probe() is allocating/disposing memory manually with
spi_alloc_host()/spi_alloc_target(), but uses
devm_spi_register_controller(). In case of error after the latter call the
memory will be explicitly freed in the probe function by
spi_controller_put() call, but used afterwards by "devm" management outside
probe() (spi_unregister_controller() <- devm_spi_unregister() below).

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
...
Call trace:
 kernfs_find_ns
 kernfs_find_and_get_ns
 sysfs_remove_group
 sysfs_remove_groups
 device_remove_attrs
 device_del
 spi_unregister_controller
 devm_spi_unregister
 release_nodes
 devres_release_all
 really_probe
 driver_probe_device
 __device_attach_driver
 bus_for_each_drv
 __device_attach
 device_initial_probe
 bus_probe_device
 deferred_probe_work_func
 process_one_work
 worker_thread
 kthread
 ret_from_fork

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/spi/spi-fsl-lpspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 11991eb126364..079035db7dd85 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -830,11 +830,11 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 
 	is_target = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
 	if (is_target)
-		controller = spi_alloc_target(&pdev->dev,
-					      sizeof(struct fsl_lpspi_data));
+		controller = devm_spi_alloc_target(&pdev->dev,
+						   sizeof(struct fsl_lpspi_data));
 	else
-		controller = spi_alloc_host(&pdev->dev,
-					    sizeof(struct fsl_lpspi_data));
+		controller = devm_spi_alloc_host(&pdev->dev,
+						 sizeof(struct fsl_lpspi_data));
 
 	if (!controller)
 		return -ENOMEM;
-- 
2.44.0


