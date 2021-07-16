Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1233CBE11
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 22:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhGPU51 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 16:57:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4776 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhGPU51 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 16:57:27 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GKeMbw010026;
        Fri, 16 Jul 2021 16:54:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39tw63kv3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:54:28 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 16GKsQit026940
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 16:54:26 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 16 Jul 2021 16:54:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 16 Jul 2021 16:54:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 16 Jul 2021 16:54:25 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 16GKsNDS003387;
        Fri, 16 Jul 2021 16:54:23 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>
CC:     <nuno.sa@analog.com>, <bootc@bootc.net>, <swarren@wwwdotorg.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <rjui@broadcom.com>,
        <f.fainelli@gmail.com>, <nsaenz@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 0/1] spi: spi-bcm2835: Fix deadlock
Date:   Sat, 17 Jul 2021 00:02:44 +0300
Message-ID: <20210716210245.13240-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jlKMay9owrbYfMeweS0lhRrhn6FYSULv
X-Proofpoint-ORIG-GUID: jlKMay9owrbYfMeweS0lhRrhn6FYSULv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160131
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The bcm2835_spi_transfer_one function can create a deadlock
if it is called while another thread already has the
CCF lock.

This behavior was observed at boot and when trying to
print the clk_summary debugfs. I had registered
at the time multiple clocks of AD9545 through the CCF.
Tested this using an RPi 4 connected to AD9545 through SPI.

See upstream attempt here:
https://lore.kernel.org/lkml/20210614070718.78041-3-alexandru.tachici@analog.com/T/

This can happen to any other clock that needs to read
the rate/phase from hardware using the SPI. Because
when issuing a clk_get_rate/phase, the requesting thread
already holds the CCF lock. If another thread, in this case
the one that does the spi transfer tries the same, it will cause
a deadlock. This happens by chance because not always
every spi request gets deferred to a khthread.

Alexandru Tachici (1):
  spi: spi-bcm2835: Fix deadlock

 drivers/spi/spi-bcm2835.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--
2.25.1
