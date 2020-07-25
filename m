Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B875122D534
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 07:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGYFUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Jul 2020 01:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgGYFUT (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 25 Jul 2020 01:20:19 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595654419;
        bh=30dRUZ6oSzi5sJo6kJChYAz9oIvr6OLCaiG4hVaZXHk=;
        h=Subject:From:Date:To:From;
        b=0tkAFN/z2i3MGVrZFAsyALSB1nFF3hVoyhTvI4c9xoo7X4BAY1EihAjhd/rVSgzcg
         4z7cOsNIkZUcrs20+XtUMIHnkE3oFPd/74axJy78rS5XCXGTT/axDD7VyFoNqxgLqn
         iisAjs8RdwPYvj42V0UYx9MaHS/gachLgQjd6kxU=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <159565441930.8907.15969357003844825985.git-patchwork-housekeeping@kernel.org>
Date:   Sat, 25 Jul 2020 05:20:19 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: correct kernel-doc inconsistency (2020-07-25T05:02:57)
  Superseding: [v1] spi: correct kernel-doc inconsistency (2020-07-19T19:56:40):
    spi: correct kernel-doc inconsistency


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
