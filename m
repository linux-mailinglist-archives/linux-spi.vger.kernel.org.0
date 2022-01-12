Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9248C696
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jan 2022 15:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354371AbiALO4R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 12 Jan 2022 09:56:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53764 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354377AbiALO4R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 12 Jan 2022 09:56:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A653BB81DFF
        for <linux-spi@vger.kernel.org>; Wed, 12 Jan 2022 14:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7834BC36AEA;
        Wed, 12 Jan 2022 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641999373;
        bh=95iGxtxnpjaKpkOtRx7d6mBQonruhLPNxHac+i0FJSM=;
        h=Subject:From:Date:To:From;
        b=XF8zYloV9bwNP7DYl6P7gRsTQD0fUrAdrbWP++qt6Zv/Z+nkifiFLg5WNFwnPBlh4
         oIpFiMIhHoB78m+ariqU9ddClRrYVv1pka8judY5XqFl0WtwKFhYtXTZOf06bGFINV
         09eJx7V1dW8OP/8fYDlJJbQvK33AI0dRsPdJ0PS2eecGGCbzYUzzcdKaxfzKjseQbo
         QzpXqvYIDKaN/iLM/ato87TyzKgKpEGIWo3OHiqvxyPDUGFSzheElFfCUdAZBNJsaA
         Ll1oIW9ESlHvaCFJZcKGELNztDg6abO2TF+fjDJ23Y8cQZo4KkYQJcqCduzkg4+j+l
         hXYzMHj4HjPiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5794AF6078C;
        Wed, 12 Jan 2022 14:56:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <164199937335.19115.7336731821987032417.git-patchwork-housekeeping@kernel.org>
Date:   Wed, 12 Jan 2022 14:56:13 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: stm32-qspi: Update spi registering (2022-01-12T14:44:24)
  Superseding: [v1] spi: stm32-qspi: Update spi registering (2022-01-06T13:20:52):
    spi: stm32-qspi: Update spi registering


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

