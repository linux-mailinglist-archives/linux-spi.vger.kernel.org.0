Return-Path: <linux-spi+bounces-4754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E14972722
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 04:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FBCB21C17
	for <lists+linux-spi@lfdr.de>; Tue, 10 Sep 2024 02:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D081442F6;
	Tue, 10 Sep 2024 02:26:28 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79F1DFE8;
	Tue, 10 Sep 2024 02:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935188; cv=none; b=AAGDnibYXqzglEoFy+QZZ4yWLKICybL5tYav/mx42bZrbWfgxcwAin3ABjEjjfw+RM7hVROMYFv0DnJDgd4in/yw0ob3fIFG5ph3Vp21GW/p9fTYAaSqdsCD16lyERHdGKeQPwACd6CPATfs4076kypBrgfA/dZcfTaFfS4b26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935188; c=relaxed/simple;
	bh=9VCRDvY8u+wzwk1sPlJ8bigTxlZTu00llrSwf4aQ360=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5nO+sNCEADLJQ3I4/AvQPx8zKMpesx5AGVZQlwRptls+N4PJfugRmcuvVKEUXaG8uOgP0gJwj8QCx2lMNm5a1iqgaTsqtCXBlW4svP11/9vM9oafttnpkRdMbr0eRpWjlUVv+xb4JOdoYMCMhAQtblRhANo5XCVWYt6w8k/thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4X2ncz5mMNz4f3jjw;
	Tue, 10 Sep 2024 10:26:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5E6C41A0359;
	Tue, 10 Sep 2024 10:26:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.48.0.27])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8dKrt9m1gKTAw--.13967S4;
	Tue, 10 Sep 2024 10:26:22 +0800 (CST)
From: Yang Yingliang <yangyingliang@huaweicloud.com>
To: broonie@kernel.org,
	hdegoede@redhat.com,
	matthias.bgg@gmail.com,
	yangyingliang@huawei.com,
	liwei391@huawei.com
Cc: linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH -next 0/7] spi: replace and remove spi_slave_abort()
Date: Tue, 10 Sep 2024 10:26:10 +0800
Message-ID: <20240910022618.1397-1-yangyingliang@huaweicloud.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8dKrt9m1gKTAw--.13967S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw4DZF4ktFyxKF18GryfZwb_yoWDXFc_AF
	yjgF4UGrW7W39xJFn2kr18X348uayFqrn2qa1vqFWUKF9rXw1UJr4UCFW7uw10vFWkGr1I
	gr17tan8ur13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/

From: Yang Yingliang <yangyingliang@huawei.com>

Switch to use spi_controller_is_target() and spi_target_abort(),
then remove spi_controller_is_slave() and spi_slave_abort().

Yang Yingliang (7):
  spi: switch to use spi_controller_is_target()
  spi: slave-time: switch to use spi_target_abort()
  spi: slave-system-control: switch to use spi_target_abort()
  spi: spidev: switch to use spi_target_abort()
  spi: slave-mt27xx: switch to use target_abort
  platform/olpc: olpc-xo175-ec: switch to use spi_target_abort().
  spi: remove spi_controller_is_slave() and spi_slave_abort()

 drivers/platform/olpc/olpc-xo175-ec.c  |  4 ++--
 drivers/spi/spi-slave-mt27xx.c         | 12 ++++++------
 drivers/spi/spi-slave-system-control.c |  2 +-
 drivers/spi/spi-slave-time.c           |  2 +-
 drivers/spi/spi.c                      | 21 +++++----------------
 drivers/spi/spidev.c                   |  2 +-
 include/linux/spi/spi.h                | 12 +-----------
 7 files changed, 17 insertions(+), 38 deletions(-)

-- 
2.33.0


