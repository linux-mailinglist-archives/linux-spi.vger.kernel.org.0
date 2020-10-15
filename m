Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9228F553
	for <lists+linux-spi@lfdr.de>; Thu, 15 Oct 2020 16:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389067AbgJOOym (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Oct 2020 10:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388348AbgJOOym (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Oct 2020 10:54:42 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602773682;
        bh=yFwUiDTQCWn4oO+HyQGrXZ/37RFpwrYTUYMU0Um6h1c=;
        h=Subject:From:Date:To:From;
        b=Thd22s7q+sx04sKrKCv2IFsXkjGoMBuAGFTxvRQrhCQ410+CruZDkiLjNCUmyOhv9
         bj00R2MwXbePXylzd48Ot1FT0hqSfCI/feTJYFIzy9jGXENsbgZA52f+2WV7bve6S+
         lccz6Ep4//mt24GwpbHKZGOB8Sl1O14Sfrsl07O8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+spi-devel-general@kernel.org
Message-Id: <160277368223.9314.14644802045097761016.git-patchwork-housekeeping@kernel.org>
Date:   Thu, 15 Oct 2020 14:54:42 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v1] spi: unbinding slave before calling spi_destroy_queue (2020-10-15T14:38:34)
  Superseding: [v1] spi: unbinding slave before calling spi_destroy_queue (2020-10-15T14:29:51):
    spi: unbinding slave before calling spi_destroy_queue


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

