Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB424EED4
	for <lists+linux-spi@lfdr.de>; Sun, 23 Aug 2020 18:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHWQpV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 23 Aug 2020 12:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHWQpU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 23 Aug 2020 12:45:20 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85154C061573
        for <linux-spi@vger.kernel.org>; Sun, 23 Aug 2020 09:45:19 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g6so6965632ljn.11
        for <linux-spi@vger.kernel.org>; Sun, 23 Aug 2020 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NOKYXZHgwL0paiwMlpmslTd8Lj9m4/WiLQePK3fb0VU=;
        b=qOQO5fvV7F5TV3zFvLM3E2Vpmf1Zhq0rkjKWx2F/QxtiUeXRLxTNQ5n81RRjcAj52N
         7lYCY5mM8xp9x2zMJGbbP1DxQHLvy3737jwoD9VWOHAbAWqsy+XKipeBCCE8pjlpjfAt
         ajYgtn3sz9GApwmDzNUZPvoNwx25cfrvGy7CLzXNXqy0SFpiwVY8NGJzyW3T8/Bs88+k
         1iVmaZZJQJl3DbsYwdisup9c62nQLGsJp37ypBPqMi2QS2BG+Jnkdk+1nJzWVdHKaSxC
         QuI0s+OIbKPmIQBiJqPUFEFcKzZ3USjrEe2G9Ju4CAF8s8WCCuQFvOdCIOPVEOwEU7zk
         Grag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NOKYXZHgwL0paiwMlpmslTd8Lj9m4/WiLQePK3fb0VU=;
        b=pjqHbRY/rVEiHb1lM6OmY7h2UnTLBacmQxKrYM8YD1kFw8Mg6SVgSWqiZl4/tDsSLf
         uUY8QiMsFMESFbq3v6NRWHVAbxVgWnEUX4Ge7mUWczSyzsoj+eHi7T7AFD4/JXJtsDfb
         8y6pZS9zBB7QBaeK5ywH2JgpyTOs0bFxjRUvGHeIfVPm8ZiXhVjujQ81fwxbyid/JKdM
         U8kTQvlV47Uetj8hMWIgxkggzMYkFzRW4AyuliIZwNzPMoAhQp8dPNQgp5MLry2HsJEH
         L3gz3TLN44A/IJ7WAazKLSKGhQPLB1rxk8PggJ4oMqIcG5o57MUGRbiJ2SViS3my6YJD
         YRxg==
X-Gm-Message-State: AOAM533FtEu2/BfVzf7NCI+QydF+NEPqt2CIVEoYxaVAUYKW8/E0NpKR
        E4wXXH0c9qtZ2MYpJbaq8KHciCOroclXHa8szDHkPybd1w==
X-Google-Smtp-Source: ABdhPJysqLD9QJEUay6hr/la6QDeNRALDleGZgLukF9xCSoG+quxRKUZglpIbMqP2NZg9g+zN2FKQJ0uc+oBskuaQkg=
X-Received: by 2002:a2e:581c:: with SMTP id m28mr828093ljb.413.1598201118007;
 Sun, 23 Aug 2020 09:45:18 -0700 (PDT)
MIME-Version: 1.0
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Date:   Sun, 23 Aug 2020 22:15:05 +0530
Message-ID: <CAD=jOEYW-uC1rDLkzxW9HTM+vj2XAbUft5iTcdk_OaY-gfZhxg@mail.gmail.com>
Subject: Regarding possible bug in drivers/spi/spi-sh.c
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, andrianov <andrianov@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

In this driver, work is activated at the end of the Interrupt handler.
It is not clear if it is possible to have another interrupt while the
work is executing. Since both spi_sh_work() and spi_sh_irq() are
accessing ss->cr1, if it is possible to have a race between these two
then lock should be held in the interrupt handler as well as
spi_sh_send() which is called from spi_sh_work(). Please let me know
if this race is possible.

Thank you,
Madhuparna
