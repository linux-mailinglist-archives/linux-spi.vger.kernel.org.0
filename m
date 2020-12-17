Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2AD2DD054
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 12:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgLQL2g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 06:28:36 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1044 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgLQL2g (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 06:28:36 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHBM0NL023538;
        Thu, 17 Dec 2020 03:27:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=epOsstKLC1pL7QQkTo5f4KG8MxmSnaZy2Ju55c2rTbI=;
 b=gI4mn84yafvs1nGogVBicBrJSiwPS1N7378/TqVEeDW33sT/zsbQB6OD2jv1g44Q/GcX
 L5pC6tmHxUsAuyZ7U1UOFkr6mXbXkFvPxx/KnJNrldaJSO96zP0Sls+PkJERFtXpc8QZ
 uux6eG4I/zZ7keqzTodmvkElSeKiGb+/5N6tYK2Mte4YFyB0MQg98tURSx0nSKltfmNC
 q2mNtvt4a37ZJokKBKtvuzHYfIadPg53fDVJk9M+1Y8Sobb9lILkV/miKk/OQp1moDb1
 WlblwHS8+2FgJVdWUt5R6tpGdypZ/rtLEMk4S1sVDm57zo4TSEukz9GbvSgnF3PhGou/ kA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tfcm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 03:27:53 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:27:51 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 03:27:51 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id B3EA83F703F;
        Thu, 17 Dec 2020 03:27:48 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH 0/3] spi: new feature and fix for Marvell Orion driver
Date:   Thu, 17 Dec 2020 13:27:05 +0200
Message-ID: <20201217112708.3473-1-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_07:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Konstantin Porotchkin <kostap@marvell.com>

This patch set contains the following:
- support for switching CS for every transferred byte
- fix for the clock by enabling it for every call to spi_setup()

Konstantin Porotchkin (1):
  dt-bindings: spi: add support for spi-1byte-cs

Marcin Wojtas (2):
  spi: orion: enable clocks before spi_setup
  spi: orion: enable support for switching CS every transferred byte

 .../bindings/spi/spi-controller.yaml          |  5 ++++
 drivers/spi/spi-orion.c                       | 30 ++++++++++++++++++-
 drivers/spi/spi.c                             |  6 ++--
 include/linux/spi/spi.h                       |  1 +
 4 files changed, 39 insertions(+), 3 deletions(-)

-- 
2.17.1

