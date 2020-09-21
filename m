Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61569271B8D
	for <lists+linux-spi@lfdr.de>; Mon, 21 Sep 2020 09:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIUHVB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Sep 2020 03:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbgIUHUR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:17 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600672817;
        bh=3fyrHKThljV+VzoFLxju+u+vrHaFCDtSkeW4j0ar8S8=;
        h=Subject:From:Date:To:From;
        b=pviz5ILSs+8E0K2QUsTLPEpg6wxJp/WeTz8WNl9i9+iG7mgi3na/dtNAaox+ySHuF
         eG+thy+fONRjSe2jOOb0kJ4R1ZyHAWCiFzEhSPxTW0EZQIKYVbUfqAmqJutp05xYEA
         PAZTOhqLNLjKgc+qnf58vj9TU882LRV80m++pkR8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From:   patchwork-bot+linux-spi@kernel.org
Message-Id: <160067281709.10506.16733000104224806627.git-patchwork-housekeeping@kernel.org>
Date:   Mon, 21 Sep 2020 07:20:17 +0000
To:     linux-spi@vger.kernel.org, broonie@kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Latest series: [v2] spi: atmel: Exposing effective spi speed (2020-09-21T07:10:36)
  Superseding: [v1] spi: atmel: Exposing effective spi speed (2020-09-18T10:37:37):
    spi: atmel: Exposing effective spi speed


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
