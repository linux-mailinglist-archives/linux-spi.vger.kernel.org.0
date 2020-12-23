Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E74B2E1B0E
	for <lists+linux-spi@lfdr.de>; Wed, 23 Dec 2020 11:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLWKjQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Dec 2020 05:39:16 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728301AbgLWKjQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Dec 2020 05:39:16 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNAabJm012304;
        Wed, 23 Dec 2020 02:38:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=6jGjpsWRQJMqD261JmxjloUC6Ol6/9eGMmzHo8AToAc=;
 b=YW41kJoNnijwXlocVlhyXnC26GHfy3IAXMdOYbXR62jjs0MInTMw8jPJBRfpu+/MaZ7W
 FPr9FBOuJmEJ+eqdkl69hBgdSf0H0Rd7EKwPbETRwjJcYihiINmLhDDKKTNlCBmHIlCa
 LeTPHR2PH2mrZ5fFczzxR69kAuJGHZQznWY192+qOjwDH49y2fdf/f3FzspfgjE67tlo
 /e0EPJkJvCwThaPnUIDVhmqfvQNgSnEkXhlFa4LZ4ZZ1d2C5t8XTNe+H6xmilY5tagXS
 2p2DaD/DIud92YcrvVc88e8WytMmZ2F+8oSBTo+VzvZPCtbkuZm98R+T0RrFXL9s6fjs /A== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebdw45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 02:38:34 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 02:38:32 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 02:38:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 02:38:33 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id 9B3393F703F;
        Wed, 23 Dec 2020 02:38:30 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 0/2] spi: new feature and fix for Marvell Orion driver
Date:   Wed, 23 Dec 2020 12:38:25 +0200
Message-ID: <20201223103827.29721-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_04:2020-12-22,2020-12-23 signatures=0
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

v3:
- use PM functions in spi_setup() instead of raw flash APIs
- shut down clocks after enablement and spi transfer setup
- report error if SPI_CS_WORD flag is set for 16 bit operations
- fall into PIO mode if spi direct mode used with SPI_CS_WORD flag

Marcin Wojtas (2):
  spi: orion: enable clocks before spi_setup
  spi: orion: enable support for switching CS every transferred byte

 drivers/spi/spi-orion.c | 55 ++++++++++++++++++--
 1 file changed, 50 insertions(+), 5 deletions(-)

-- 
2.17.1

