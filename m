Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416051FA7DA
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 06:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgFPEkR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 00:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPEkR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 16 Jun 2020 00:40:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592282416;
        bh=qhkFTbzLIjC0qCbpevtvOvb4/YHo8fKjFgRrtAgyEAI=;
        h=Subject:From:Date:To:From;
        b=AKgosTNgiITqj0oqIVYgAjUxt3WZGIh6y7G6yxPEv+hmXRIj62bK08tP1YUdKv861
         aj5mOrHIhveNgnCdbqmAyIpk+4SpRoKvK6rJCnM/6D04rlXyh7JVawOLfVbte09E0q
         wHw9uiavEljduaqFtgzuYkUm8IIiADFsE2LBOlI4=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159228241662.11635.3312496003661387561.git-patchwork-housekeeping@kernel.org>
Date:   Tue, 16 Jun 2020 04:40:16 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-16T04:26:15)
  Superseding: [v2] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-04T01:55:28):
    [V2,1/3] dt-bindings: spi: Convert mxs spi to json-schema
    [V2,2/3] dt-bindings: spi: Convert imx cspi to json-schema
    [V2,3/3] dt-bindings: spi: Convert imx lpspi to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
