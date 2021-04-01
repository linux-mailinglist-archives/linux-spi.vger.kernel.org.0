Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478E5350FAB
	for <lists+linux-spi@lfdr.de>; Thu,  1 Apr 2021 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAG7q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Apr 2021 02:59:46 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:33238 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhDAG7W (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Apr 2021 02:59:22 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 3805A980063;
        Thu,  1 Apr 2021 14:59:20 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] linux/spi: Remove repeated struct declaration
Date:   Thu,  1 Apr 2021 14:59:04 +0800
Message-Id: <20210401065904.994121-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTE5NTUIeTB8eQkMeVkpNSkxJTUtITUtPSUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCI6Axw*HD8KEjQeHhI2GB9L
        URQaCRFVSlVKTUpMSU1LSE1LTEhJVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0tJNwY+
X-HM-Tid: 0a788c3ab294d992kuws3805a980063
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

struct spi_transfer is declared twice. One is declared at 24th line.
The blew one is not needed though. Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/spi/spi.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 592897fa4f03..c345392a11ee 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -247,7 +247,6 @@ static inline void *spi_get_drvdata(struct spi_device *spi)
 }
 
 struct spi_message;
-struct spi_transfer;
 
 /**
  * struct spi_driver - Host side "protocol" driver
-- 
2.25.1

