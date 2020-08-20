Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D624C3FF
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgHTRC5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:02:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729767AbgHTRCj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:02:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KGrmx5016745;
        Thu, 20 Aug 2020 13:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=49g9O54YdjuDR0h4JE4h4tBrQTnCIZqBJ7/F6tsyfP0=;
 b=i6SWEOhwX0WQv1puW29SBFlNgevG122h7ZrtcEpklXtUzBBGp1Io3Bvv3MS1QSUUTuBv
 To/v0K3B2MHZ1IwYfumnIFdVQgpWepja56HynY1imlRr3zDZC+mOhR96FRo1F6mCsd93
 y9we+/XHAxKTk2Ecw/xtftN2x9z5xo7SWVgm9U/diFkePjsJnXaOJR9z41BFw0orAEvG
 cy+nKT3KXe/hQmHnyxOwtx6QKgC7gNp5oubi5ZQAr7RFlXlp6UMIv+yoS0xfhJw05G02
 8NtfhRjDecktyqDtrFje74E8JtSRAkH7T7m2CYBs5BEB3VnC5nYhft3Lq0xKnpmTzIJg jQ== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3311yeqgre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:02:33 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KH0K1t001566;
        Thu, 20 Aug 2020 17:02:30 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 3304cedu8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:30 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2UeH28967174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56034AE067;
        Thu, 20 Aug 2020 17:02:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66032AE062;
        Thu, 20 Aug 2020 17:02:29 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:29 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 0/7] spi: Fix FSI-attached controller and AT25 drivers
Date:   Thu, 20 Aug 2020 12:02:21 -0500
Message-Id: <20200820170228.42053-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=373 clxscore=1011 suspectscore=1
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200135
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series implements a number of fixes for the FSI-attached SPI controller
driver and the AT25 eeprom driver.

Brad Bishop (4):
  spi: fsi: Handle 9 to 15 byte transfers lengths
  spi: fsi: Fix clock running too fast
  spi: fsi: Fix use of the bneq+ sequencer instruction
  eeprom: at25: Split reads into chunks and cap write size

Eddie James (3):
  dt-bindings: fsi: fsi2spi: Document new restricted property
  spi: fsi: Implement restricted size for certain controllers
  spi: fsi: Check mux status before transfers

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |  10 ++
 drivers/misc/eeprom/at25.c                    |  94 +++++++-----
 drivers/spi/spi-fsi.c                         | 139 ++++++++++++++----
 3 files changed, 172 insertions(+), 71 deletions(-)

-- 
2.26.2

