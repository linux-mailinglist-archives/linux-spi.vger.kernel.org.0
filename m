Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3AD17987E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Mar 2020 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCDTAO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Mar 2020 14:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDTAO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Mar 2020 14:00:14 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583348414;
        bh=6F6N6gBxpvE4yAVRZ01VACcVvbBi85N0+l+/9Ynj6BY=;
        h=Subject:From:Date:To:From;
        b=W0pkSgMlLlFpTlE0BnxALTctLbUw3MSpWaqEGBaQgXAOAJUIilrklG5IQ4LZi2Uib
         TDPINiyTbp+q2lrG2XnYQLqUS9jQrjXCzhJDbEjFZGHgn3QeBUlj37/azFlmkphrHu
         chd87UOCrLGOuOMdCFXAbOXMfG1mt7sJlQQuAdss=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <158334841417.14287.16077889170110404308.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 04 Mar 2020 19:00:14 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v3] dt-bindings: spi: convert rockchip spi bindings to yaml (2020-03-04T18:42:01)
  Superseding: [v2] dt-bindings: spi: convert rockchip spi bindings to yaml (2020-01-22T22:45:54):
    [v2,1/3] dt-bindings: spi: convert rockchip spi bindings to yaml
    [v2,2/3] dt-bindings: spi: spi-rockchip: add description for rk3308
    [v2,3/3] dt-bindings: spi: spi-rockchip: add description for rk3328


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
