Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1301151C5
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 15:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFOC3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 09:02:29 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:49374 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfLFOC3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 09:02:29 -0500
X-Greylist: delayed 1176 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 09:02:29 EST
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB6DgMJh000675;
        Fri, 6 Dec 2019 08:42:34 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffmn5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 08:42:34 -0500
Received: from pbmxdp02.intersil.corp (132.158.200.223) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Fri, 6 Dec 2019 08:42:32 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp02.intersil.corp (132.158.200.223) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 6 Dec 2019 08:42:31 -0500
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
Subject: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
Date:   Fri, 6 Dec 2019 08:41:56 -0500
Message-ID: <20191206134202.18784-1-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912060118
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Renesas SPI Bus Space Controller (SPIBSC) HW was specifically designed for
accessing Serial flash devices (QSPI, HyperFlash, Octa Flash). In the hardware
manuals, it is almost always labeled as the "Renesas SPI Multi I/O Bus Controller".
However, the HW IP is usually referred to within Renesas as the "SPI BSC".
Yes, the R-Car team nicknamed it RPC (for "Reduced Pin Count" flash) after HyperFash
support was added...but I personally think that RPC is not a good name for this
HW block.


This driver has been tested on an RZ/A1H RSK and RZ/A2M EVB.

The testing mostly consisted of formatting an area as JFFS2 and doing copying
of files and such.

While the HW changed a little between the RZ/A1 and RZ/A2 generations, the IP
block in the RZ/A2M was taken from the R-Car H3 design, so in theory this
driver should work for R-Car Gen3 as well.

=========================
Version 2 changes
=========================
* I got rid of all the critical clock stuff. The idea is is that if you are
  planning on using the SPI BSC, even in XIP mode, it should be described in DT.

* There is no actual 'runtime pm' implmented in the driver at the moment, and
  so just the standard enable/disable clock API is used.

* The compatible string "jedec,spi-nor" will be used to determine if a spi controller
  needs to be regitered or not. At the moment there is no setup needed for
  running in XIP mode, so we just need to signal that the peripheral clock should
  be left on and then we're done.




Chris Brandt (6):
  spi: Add SPIBSC driver
  dt-bindings: spi: Document Renesas SPIBSC bindings
  clk: renesas: r7s9210: Add SPIBSC clock
  ARM: dts: r7s72100: Add SPIBSC devices
  ARM: dts: r7s9210: Add SPIBSC device
  ARM: dts: gr-peach: Enable SPIBSC

 .../bindings/spi/renesas,spibsc.yaml          | 115 ++++
 arch/arm/boot/dts/r7s72100-gr-peach.dts       |   5 +
 arch/arm/boot/dts/r7s72100.dtsi               |  25 +-
 arch/arm/boot/dts/r7s9210.dtsi                |  11 +
 drivers/clk/renesas/r7s9210-cpg-mssr.c        |   1 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-spibsc.c                      | 612 ++++++++++++++++++
 8 files changed, 776 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,spibsc.yaml
 create mode 100644 drivers/spi/spi-spibsc.c

-- 
2.23.0

