Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3765C171D96
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 15:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389446AbgB0OVm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 09:21:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13086 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389376AbgB0OVl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 09:21:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01REFGbD028614;
        Thu, 27 Feb 2020 09:21:40 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ydtrx3dg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 09:21:40 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01RELc4X002227
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 27 Feb 2020 09:21:39 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 27 Feb
 2020 06:21:37 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 27 Feb 2020 06:21:37 -0800
Received: from analog.ad.analog.com ([10.48.65.180])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01RELZhp030157;
        Thu, 27 Feb 2020 09:21:35 -0500
From:   Sergiu Cuciurean <sergiu.cuciurean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>
CC:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: [PATCH] spi: spi-mpc52xx: Use new structure for SPI transfer delays
Date:   Thu, 27 Feb 2020 16:21:31 +0200
Message-ID: <20200227142131.14940-1-sergiu.cuciurean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_04:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270113
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In a recent change to the SPI subsystem [1], a new `delay` struct was added
to replace the `delay_usecs`. This change replaces the current
`delay_usecs` with `delay` for this driver.

The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
that both `delay_usecs` & `delay` are used (in this order to preserve
backwards compatibility).

[1] commit bebcfd272df6 ("spi: introduce `delay` field for
`spi_transfer` + spi_transfer_delay_exec()")
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
 drivers/spi/spi-mpc52xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index ef2f24420460..d1ea402555ca 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -248,7 +248,9 @@ static int mpc52xx_spi_fsmstate_transfer(int irq, struct mpc52xx_spi *ms,
 	ms->len--;
 	if (ms->len == 0) {
 		ms->timestamp = get_tbl();
-		ms->timestamp += ms->transfer->delay_usecs * tb_ticks_per_usec;
+		ms->timestamp += spi_delay_to_ns(&ms->transfer->delay,
+						 ms->transfer) *
+				 tb_ticks_per_usec;
 		ms->state = mpc52xx_spi_fsmstate_wait;
 		return FSM_CONTINUE;
 	}
-- 
2.17.1

