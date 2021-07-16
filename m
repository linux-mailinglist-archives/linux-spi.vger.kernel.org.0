Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9533CB7F4
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbhGPNmZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 09:42:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232839AbhGPNmZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 09:42:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GDXT5d169632;
        Fri, 16 Jul 2021 09:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=G7xR0UkTlt4DxDG1uLnHNASS4R8Bl3dF6j6aZ38n9vo=;
 b=VkYJB2m2lCM5k34wsfNR00uVr0X1Yy7ByD2ks25PzRMKndjEePYirRplwV+EEqcEbyYs
 p3zwGKL37mlLTQUpxlNhb6WLD5V5cDOrK4ZYrXioRK17KSFEG22TfyySCaErUj2wFcBl
 pTSco8UvF+B+WjMzseRJsMbLMOVSMlVVIPPysgDTfQ6oiVFAoeb5x59kKOwP8sFkYSXU
 705eHeoq5D1qtDEX/i4XMGkkmVyU7SRpHmRyQV7F06FF0fqoeq8sfArOu+pDl6kYJNak
 bQoI6fJem7cHVbBe3XVbgdVp+uBQdNz/jfnpstoXqBsbpCmSCUVE8Lr34N+hTVxV6WUq qg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39u8bvwe9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 09:39:24 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GDXgIl015997;
        Fri, 16 Jul 2021 13:39:22 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma05wdc.us.ibm.com with ESMTP id 39q36f49yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 13:39:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GDdL8850004384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 13:39:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6C266E053;
        Fri, 16 Jul 2021 13:39:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 465CD6E04E;
        Fri, 16 Jul 2021 13:39:21 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.92.96])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 13:39:21 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, openbmc@lists.ozlabs.org,
        joel@jms.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 0/2] spi: fsi: Reduce max transfer size to 8 bytes
Date:   Fri, 16 Jul 2021 08:39:13 -0500
Message-Id: <20210716133915.14697-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0I2MU2yPyw5_GN2utrm0UNo4jKhHkX90
X-Proofpoint-ORIG-GUID: 0I2MU2yPyw5_GN2utrm0UNo4jKhHkX90
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=723 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160082
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The security restrictions on the FSI-attached SPI controllers have
been applied universally to all controllers, so the controller can no
longer transfer more than 8 bytes for one transfer. Refactor the driver
to remove the looping and support for larger transfers, and remove the
"restricted" compatible string, as all the controllers are now
considered restricted.

Eddie James (2):
  spi: fsi: Reduce max transfer size to 8 bytes
  dt-bindings: fsi: Remove ibm,fsi2spi-restricted compatible

 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  |   1 -
 drivers/spi/spi-fsi.c                         | 125 +++---------------
 2 files changed, 22 insertions(+), 104 deletions(-)

-- 
2.27.0

