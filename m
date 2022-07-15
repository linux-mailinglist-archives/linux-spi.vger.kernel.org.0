Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78507576375
	for <lists+linux-spi@lfdr.de>; Fri, 15 Jul 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiGOONv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Jul 2022 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiGOONt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 15 Jul 2022 10:13:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5BB493
        for <linux-spi@vger.kernel.org>; Fri, 15 Jul 2022 07:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657894427; x=1689430427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5s0qRLHgkSjM5AY2vqOMfzZmbKyjDGXVrUPOcHa/fP4=;
  b=DCBMTHFZhvQhR7KIgaW+lwZ+Mi3DNSWKLzIBlc6c8whodP1dVh12NQi7
   Ql+iu6aghIcmfeiXWNlpQGk1MmnyNiXMUywsFqSbcM42cnUwaNMCn1St+
   tqzqJJDsRyzXtmSuNF1El5sOEurzqVn9v/3UqN8NkN4boDGzQW9WWc7gV
   p7J2ATr7fMhyvwBfUDHzzZrG4wucVu1KPTg5nAXifldHp0svUNyEf57CJ
   byHvQANB0ktPrxuJ5zO5otep+cjH28l9AoTU4ra6bJ7cY4yJv0+ld8HVp
   PGOjhdfwfFcuZkKekrjAU0gp55wxR65oDchxs0E47eIiqSzxMxq8t6rQ0
   w==;
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; 
   d="scan'208";a="172301575"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2022 07:13:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 15 Jul 2022 07:13:45 -0700
Received: from HNO-LT-M43677A.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 15 Jul 2022 07:13:44 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <david@protonic.nl>
CC:     <andrew@lunn.ch>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <mkl@pengutronix.de>
Subject: Re: [PATCH v3 00/11] Optimize spi_sync path
Date:   Fri, 15 Jul 2022 16:13:42 +0200
Message-ID: <20220715141342.12330-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621061234.3626638-1-david@protonic.nl>
References: <20220621061234.3626638-1-david@protonic.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi David,
 
some numbers after testing your patch on a RPI 5.15.y vs 5.19rc6 and the mcp2518fd:

Two Backtoback SPI transfers with 9 byte each went from 78us to 36us! All metrics improved (cs to first clock cyle, last clock cycle to cs, and delay between two transfers). That's a great help for the mcp driver (or any similar SPI device).

Thanks for your work on this!
-Thomas
