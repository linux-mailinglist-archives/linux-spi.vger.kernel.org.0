Return-Path: <linux-spi+bounces-4505-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DA968820
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3367F1C21FFB
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFFB1DAC47;
	Mon,  2 Sep 2024 12:59:58 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE7185934;
	Mon,  2 Sep 2024 12:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281998; cv=none; b=iFyvbSDzAbytRcPmzHMmerbmp84DDtL1i+htijd7LeGvON9XqsQdj5sNso4MUljfesGpdOE0zTGwbYAEFAJSBnrwNB14ptIZbAMO4ybqZHwgbceia8may7CFH5kb85PLBBoE5CR0HUkNs/U2iDIpoP/VUb2OSLGoJ6cahkYePCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281998; c=relaxed/simple;
	bh=kHnq+v6zcq0uJMl19BJVTKXg4qGgDN1TgTM/IMTIg/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ayk7kodpeZ0w2lD9qpBm/e9wOv2ygs96L3xD3hpNvT3AL4a4kMUX2qnYgAhSjDeoRTgMOF3OVvJ9GchmaBYZgj99EvtqwD0NxYV/Iy7ajxgYfsXPX2WMHe/7OqugQ9APGxKiii7gS2j/7zQrD2XZCinhwePF1sYDa3+T2ad/Oq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wy83d3bpYz4f3jt9;
	Mon,  2 Sep 2024 20:59:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AE0431A018D;
	Mon,  2 Sep 2024 20:59:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.85.165.202])
	by APP4 (Coremail) with SMTP id gCh0CgD3KsfEttVmOJPAAA--.25304S4;
	Mon, 02 Sep 2024 20:59:51 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	mchehab@kernel.org,
	Jonathan.Cameron@huawei.com,
	rmfrfs@gmail.com,
	vireshk@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de,
	corbet@lwn.net,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH -next 0/7] spi: replace and remove {devm_}spi_alloc_master/slave()
Date: Mon,  2 Sep 2024 20:59:40 +0800
Message-ID: <20240902125947.1368-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3KsfEttVmOJPAAA--.25304S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4UuF4DWFW5KFy5KF4kWFg_yoWDtrb_CF
	98Z3W7W39rKFn5tFn2vrn3ZrW093yFgr4ktFn0q3y3AryxXr48Jw47uF45Zry7ZF4UCF15
	GryIq3yavr1YgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use {devm_}spi_alloc_host/target() in drivers and remove
{devm_}spi_alloc_master/slave() in spi driver.

Yang Yingliang (7):
  media: usb/msi2500: switch to use spi_alloc_host()
  media: netup_unidvb: switch to use devm_spi_alloc_host()
  spi: ch341: switch to use devm_spi_alloc_host()
  spi: slave-mt27xx: switch to use spi_alloc_target()
  video: fbdev: mmp: switch to use spi_alloc_host()
  staging: greybus: spi: switch to use spi_alloc_host()
  spi: remove {devm_}spi_alloc_master/slave()

 .../driver-api/driver-model/devres.rst        |  4 +--
 .../media/pci/netup_unidvb/netup_unidvb_spi.c |  6 ++--
 drivers/media/usb/msi2500/msi2500.c           |  4 +--
 drivers/spi/spi-ch341.c                       |  2 +-
 drivers/spi/spi-slave-mt27xx.c                |  4 +--
 drivers/spi/spi.c                             | 14 ++++-----
 drivers/staging/greybus/spilib.c              |  6 ++--
 drivers/video/fbdev/mmp/hw/mmp_spi.c          |  6 ++--
 include/linux/spi/spi.h                       | 30 -------------------
 9 files changed, 23 insertions(+), 53 deletions(-)

-- 
2.33.0


