Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACAFAB3610
	for <lists+linux-spi@lfdr.de>; Mon, 16 Sep 2019 10:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfIPIAI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Sep 2019 04:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbfIPIAI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Sep 2019 04:00:08 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568620807;
        bh=ugXFOPzZz+K2he4UZZ5wnfJIlMkO5nCF/c8V7RwZqkI=;
        h=Subject:From:Date:To:From;
        b=ddCadeS5NLRE06AEacql6veuI/dNRqEeT+hnw+5o5XjiqzkX2Jc5xPKueYfPQmzcH
         k+VGJeZ7zwicAnHktM1EcNVU+FrAwZsSGsEEEd3SiHdm30GXqQjfr2x7rLowypSNub
         RFPNp9/SrE1rjxDKzMHoFwQcH3kMLUcXlIBqbWnk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <156862080773.20954.14985369328888193492.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 16 Sep 2019 08:00:07 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] dt-bindings: hspi: Convert bindings to json-schema (2019-09-16T07:53:52)
  Superseding: [v1] dt-bindings: hspi: Convert bindings to json-schema (2019-09-13T12:21:51):
    dt-bindings: hspi: Convert bindings to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
