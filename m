Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A39110F61F
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 05:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfLCEE5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 23:04:57 -0500
Received: from pbmsgap01.intersil.com ([192.157.179.201]:34908 "EHLO
        pbmsgap01.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCEE5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 23:04:57 -0500
Received: from pps.filterd (pbmsgap01.intersil.com [127.0.0.1])
        by pbmsgap01.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB33hWLh032292;
        Mon, 2 Dec 2019 22:45:51 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap01.intersil.com with ESMTP id 2wkmu327q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:45:51 -0500
Received: from pbmxdp01.intersil.corp (132.158.200.222) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Mon, 2 Dec 2019 22:45:49 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 2 Dec 2019 22:45:48 -0500
From:   Chris Brandt <chris.brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 0/6] spi: Add Renesas SPIBSC controller
Date:   Mon, 2 Dec 2019 22:45:13 -0500
Message-ID: <20191203034519.5640-1-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912030031
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Renesas SPI Bus Space Controller (SPIBSC) HW was specifically designed for
accessing SPI flash devices. In the hardware manuals, it is almost always
labeled as the "Renesas SPI Multi I/O Bus Controller". However, the HW IP is
usually referred to within Renesas as the "SPIBSC" block.

This driver has been tested on an RZ/A1H RSK and RZ/A2M EVB.

The testing mostly consisted of formatting an area as JFFS2 and doing copying
of files and such.

While the HW changed a little between the RZ/A1 and RZ/A2 generations, the IP
block in the RZ/A2M was taken from the R-Car H3 design, so in theory this
driver should work for R-Car Gen3 as well.



Chris Brandt (6):
  clk: renesas: mstp: Add critical clock from device tree support
  ARM: dts: r7s72100: Add SPIBSC clocks
  clk: renesas: r7s9210: Add SPIBSC clock
  spi: Add SPIBSC driver
  ARM: dts: r7s9210: Add SPIBSC Device support
  dt-bindings: spi: Document Renesas SPIBSC bindings

 .../bindings/spi/spi-renesas-spibsc.txt       |  48 ++
 arch/arm/boot/dts/r7s72100.dtsi               |  26 +-
 arch/arm/boot/dts/r7s9210.dtsi                |  10 +
 drivers/clk/renesas/clk-mstp.c                |  16 +-
 drivers/clk/renesas/r7s9210-cpg-mssr.c        |   9 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spibsc.c                      | 609 ++++++++++++++++++
 8 files changed, 719 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
 create mode 100644 drivers/spi/spi-spibsc.c

-- 
2.23.0

