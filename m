Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B22B98B7
	for <lists+linux-spi@lfdr.de>; Thu, 19 Nov 2020 18:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgKSQ4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 19 Nov 2020 11:56:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbgKSQ4f (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 19 Nov 2020 11:56:35 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804995;
        bh=xYWxRJp713rBAICvLHgTVWPn6ubmV/AS9B+HT63Ihwc=;
        h=Subject:From:Date:To:From;
        b=dsMLRQx3eRAnLmj6TBgtcORhyJThGJdW+pATXXq6kfmiV5MIh3N6uPe6TO6OLfJ1f
         K/5X5OGE3XlzuEjG5Eh5XyCHPEj85WoI/HAv+KXOrEhq4MFhOtrB2jMqyrSfpSr5EC
         zC1+WzwtSE/us53pwInwRHr5N+oc2PctYrZ4LOuc=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160580499488.9652.4755480284215343874.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 19 Nov 2020 16:56:34 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: fix resource leak for drivers without .remove callback (2020-11-19T16:16:02)
  Superseding: [v1] spi: fix resource leak for drivers without .remove callback (2020-11-19T15:20:57):
    [1/3] spi: fix resource leak for drivers without .remove callback
    [2/3] spi: Use bus_type functions for probe, remove and shutdown
    [3/3] spi: Warn when a driver's remove callback returns an error


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

