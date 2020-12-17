Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487B32DD5BA
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgLQRLA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:11:00 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50502 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbgLQRLA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 12:11:00 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHH5hi8018917;
        Thu, 17 Dec 2020 09:10:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ClEaVtohDgfm2PEX4c5wAG7Jzltn305pndCxRugCoOk=;
 b=EK4O3nHJdNp8Uia+H5UwN/nSzG3CZVUZCdmTf/hNHNI5E99gbIeX0mW2kt5gUr+76jKp
 060UKI/4YBejW9vDqk4m0DQsm0YKw0s5vmErCuWt21f3h3LUZrfWqC7XwGCd8M+3rlI6
 J2e3TJEdJ4AtwnQDJhTUEv8sMys19YA6LV9Wl3Zova8eznOYWjeRDWq7OE04wvY7nn7A
 5luvG7VXI6o11FGCtpnXpfgk7mXrBnUjeDeiNo6XXkIqYrAAW0kUfTeGaX2yQGf1/asI
 6W+DoYyuls64uXvHy39CEvO3+bnkzwZGk3jFNKcbQ/0fdClf84oKyL9+lXFtmL6WAdVp Hg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 35g4rp17wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:10:18 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:10:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:10:17 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id A6D393F7043;
        Thu, 17 Dec 2020 09:10:13 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 0/2] spi: new feature and fix for Marvell Orion driver
Date:   Thu, 17 Dec 2020 19:09:30 +0200
Message-ID: <20201217170933.10717-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch set contains the following changes:
- support for switching CS for every transferred byte
- fix for the clock by enabling it for every call to spi_setup()

v2:
- remove DTS entry for single byte CS, use existing SPI_CS_WORD flag
- drop changes to core SPI driver
- fix the wrong first patch signature

Marcin Wojtas (2):
  spi: orion: enable clocks before spi_setup
  spi: orion: enable support for switching CS every transferred byte

 drivers/spi/spi-orion.c | 34 +++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

-- 
2.17.1

