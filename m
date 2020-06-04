Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC671EDB1C
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jun 2020 04:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFDCUP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jun 2020 22:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgFDCUP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 3 Jun 2020 22:20:15 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591237215;
        bh=pn1JuVQFm+aHXQeH9NGf5KtJxSKNXmMEFoeLpVnmruM=;
        h=Subject:From:Date:To:From;
        b=dNWsB05hUQhA4X1FZiC/hUSAKsU+mkoE5pzmpBUZLjlOaPa6BEGT0G6Vi29DrfL0g
         arpfPeBc5unAXa2oFDEsCxTp4ZyWtgkvLnne1k9CDS23QNFCnmHfqn1EyVUISJ3rQa
         z8/vbelmUFNqmxfnsXe3U5XEVek1lJveVh+tHgBA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159123721555.21865.14695315803898344928.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 04 Jun 2020 02:20:15 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-04T01:55:28)
  Superseding: [v1] Convert mxs/imx spi/cspi/lpspi binding to json-schema (2020-06-03T06:13:26):
    [1/3] dt-bindings: spi: Convert mxs spi to json-schema
    [2/3] dt-bindings: spi: Convert imx cspi to json-schema
    [3/3] dt-bindings: spi: Convert imx lpspi to json-schema


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
