Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40682DD5C2
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgLQRLK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:11:10 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23460 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728813AbgLQRLK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 12:11:10 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHH5CHE006829;
        Thu, 17 Dec 2020 09:10:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=2J+py0vdCBDwjjREvAeZedSKU7opR6BDBpyPv1oaoB4=;
 b=UKyvAEmZyfZzUeY+LNWFf1UaCtEIsDipj1YulLKCuwEeY8xcP0KRR/vYf/or+Cr7wmaN
 /B4SQ1Hs6NxgKwuaKlI+60o4FaB5PkRlSOHK5urpXKoF/hyWJG0By/S+27UB++1cLhvH
 O+mi9ksEeD4rEOKNCSW+TcszREkES4Sy6kRAUtpH+amUiY8NntgzGEbvkvxjZgULuNEM
 NJYMSbdwf+RsV1/0XjXGX5BtooeR+jR2Vz/IIQ6A7VrWNjPIXioAcazMQeP+E5jUCuHe
 Mk+pCMjR4rJrEoxyQvpddo7RXTgQsLRjXCGNVDJx2Syq/WFOc28EcZvq+lhjdbzeXPps JQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tgb4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:10:27 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:10:25 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:10:25 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id EBD993F7040;
        Thu, 17 Dec 2020 09:10:22 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 0/2] spi: new feature and fix for Marvell Orion driver
Date:   Thu, 17 Dec 2020 19:09:33 +0200
Message-ID: <20201217170933.10717-4-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217170933.10717-1-kostap@marvell.com>
References: <20201217170933.10717-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch set contains the following:
- support for switching CS for every transferred byte
- fix for the clock by enabling it for every call to spi_setup()

v2:
- remove DTS entry for single byte CS, use existing SPI_CS_WORD flag
- drop changes to core SPI driver
- fix the wrong first patch signature

Marcin Wojtas (2):
  spi: orion: enable clocks before spi_setup
  spi: orion: enable support for switching CS every transferred byte

 drivers/spi/spi-orion.c | 30 +++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

-- 
2.17.1

