Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFF02638FB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 00:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIIW3J (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 18:29:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32396 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727782AbgIIW3I (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 18:29:08 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089MRYK2097724;
        Wed, 9 Sep 2020 18:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IkJ80Y1POR7TpH9syCU5eT96eUJswMK1blGxXzjoJQk=;
 b=g6M/FfgKHiaf6Fj722WB3LNtIsYbOWU+4mHHC5ZYBCoiOVx4X9uvCmX1o3zsEIfWofvv
 re6PP5lqEgpSP6vpvPAfbiQxwlSdZFe2Xs51Xoxnws4I6Uqnsy9FoQdIvlLV5s5GA6Gp
 8wxwJQzb0Y5CT2F3gbZaUTv5QXpMj0qTb7/3xByZa0zKhYUHhYtZSOx92T2NRPuV1yaY
 gReGqEN1czspBF66w5w7bMRaxFFoVh7LnZTD4lYrIxF54ed14TsMhXKQaEmVoKaMD7dN
 HcXzORrkN3kR7KK5UGdl1Liwwq+sHRTpDozAsVYD8XAvBmKn3E1g+I1HpfcdNJ2OJKy5 FQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f7v5810r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:29:00 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MRU5Q012722;
        Wed, 9 Sep 2020 22:29:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 33c2a9arc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:28:59 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MStWd37028442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:28:55 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB7EB136053;
        Wed,  9 Sep 2020 22:28:58 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 610BB136055;
        Wed,  9 Sep 2020 22:28:58 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.76.239])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:28:58 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, broonie@kernel.org, bradleyb@fuzziesquirrel.com,
        robh+dt@kernel.org, arnd@arndb.de, eajames@linux.ibm.com
Subject: [PATCH v2 0/6] spi: Fixes for FSI-attached controller
Date:   Wed,  9 Sep 2020 17:28:51 -0500
Message-Id: <20200909222857.28653-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=1 mlxlogscore=764 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090189
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series implements a number of fixes for the FSI-attached SPI
controller driver.

Changes since v1:
 - Switch to a new compatible string for the restricted version of the
   SPI controller, rather than a new boolean parameter.

Brad Bishop (3):
  spi: fsi: Handle 9 to 15 byte transfers lengths
  spi: fsi: Fix clock running too fast
  spi: fsi: Fix use of the bneq+ sequencer instruction

Eddie James (3):
  dt-bindings: fsi: fsi2spi: Add compatible string for restricted
    version
  spi: fsi: Implement restricted size for certain controllers
  spi: fsi: Check mux status before transfers

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |   1 +
 drivers/spi/spi-fsi.c                         | 139 ++++++++++++++----
 2 files changed, 109 insertions(+), 31 deletions(-)

-- 
2.26.2

