Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F1F242BC6
	for <lists+linux-spi@lfdr.de>; Wed, 12 Aug 2020 17:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHLPBH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Aug 2020 11:01:07 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:18149 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726226AbgHLPBA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Aug 2020 11:01:00 -0400
X-IronPort-AV: E=Sophos;i="5.76,304,1592838000"; 
   d="scan'208";a="54233294"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Aug 2020 00:00:58 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 50E6D4009401;
        Thu, 13 Aug 2020 00:00:56 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: [PATCH 0/2] r8a7742 add QSPI support
Date:   Wed, 12 Aug 2020 16:00:46 +0100
Message-Id: <20200812150048.27721-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi All,

This patchset adds qspi node to r8a7742 (RZ/G1H) SoC along
with updating the DT binding. 

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: spi: renesas,rspi: Add r8a7742 to the compatible list
  ARM: dts: r8a7742: Add QSPI support

 .../devicetree/bindings/spi/renesas,rspi.yaml    |  1 +
 arch/arm/boot/dts/r8a7742.dtsi                   | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.17.1

