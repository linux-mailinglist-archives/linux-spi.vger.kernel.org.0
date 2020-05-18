Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866E81D8965
	for <lists+linux-spi@lfdr.de>; Mon, 18 May 2020 22:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgERUkO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 18 May 2020 16:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgERUkO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 18 May 2020 16:40:14 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589834413;
        bh=Qxgta99rqYrbL6VSDdGQTn5A+OZ8vBnrjHA5iR+SgnM=;
        h=Subject:From:Date:To:From;
        b=EmiHyV9xxReQPW70gQrKbkT+QtBC5uGcUT81IZouzFuRs5aswgD+Kb9umE/XWYacB
         FF+TpFQjKPh0Pkqvo0DxWuMXjifW6PZCEt8lT7arOTQuJO4iwj12aXAlutXXcsMERq
         1M4li1AUHtdfg/BitOSuJpDKToHVoN4oJtl5NW8Y=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158983441387.12872.1221584071219973627.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 18 May 2020 20:40:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] Add Renesas RPC-IF support (2020-05-18T20:31:50)
  Superseding: [v2] Add Renesas RPC-IF support (2020-04-30T20:45:02):
    [v2,1/2] dt-bindings: memory: document Renesas RPC-IF bindings
    [v2,2/2] memory: add Renesas RPC-IF driver


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
