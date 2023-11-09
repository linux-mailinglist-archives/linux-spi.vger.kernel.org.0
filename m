Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5881C7E6617
	for <lists+linux-spi@lfdr.de>; Thu,  9 Nov 2023 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjKIJCb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Nov 2023 04:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbjKIJCV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Nov 2023 04:02:21 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E22327E;
        Thu,  9 Nov 2023 01:01:35 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 8B23D3D5;
        Thu,  9 Nov 2023 10:01:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1699520493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxMbcY/e1xBdm1kHqpKXU8h0D30T+AAVfHqRvOCfn5Q=;
        b=jPRanmdocpUy+Igu7sQQ0R5rxTsdnpZcqlsPMScXjYE866CZS5STgv4qlQDPLhKDvqCLqG
        5n9kCo/nT2ow3PCTgyxiriqy1LilBZ09dI+WesSJKes0mI0Z4zSNi8g5YyKuBAI/Vg3lQK
        RuRvMEpd79uqTCPQQYPM40JZH+AEojNVtGjz36LlR8rY3qNXoU8PCKWesfeStMMOuoqtsX
        LXzN7dO+SzGII2JFOhEgVV0Qm5SHsqFcuT/5ayU+rxhP8wZsuKi4dddmAVAtPAFrnXgPSE
        uEst/NlxHTm7tihAj6lPtSNVrYdXaqqlAsmJ/K83PoZI23SkqSGpQxeZ9BWCZw==
MIME-Version: 1.0
Date:   Thu, 09 Nov 2023 10:01:33 +0100
From:   Michael Walle <michael@walle.cc>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.au@gmail.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] Add set_iofv() callback
In-Reply-To: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
References: <20231108171149.258656-1-biju.das.jz@bp.renesas.com>
Message-ID: <877590a5e3f8c32ec0a032385049a563@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Biju,

> As per section 8.14 on the AT25QL128A hardware manual[1],
> IO0..IO3 must be set to Hi-Z state for this flash for fast read quad 
> IO.
> Snippet from HW manual section 8.14:
> The upper nibble of the Mode(M7-4) controls the length of the next FAST
> Read Quad IO instruction through the inclusion or exclusion of the 
> first
> byte instruction code. The lower nibble bits of the Mode(M3-0) are 
> don't
> care. However, the IO pins must be high-impedance before the falling 
> edge
> of the first data out clock.

I'm still not sure what you are trying to fix here. For any quad I/O 
mode,
the pins of the controller must be in hiZ during the data phase on a 
read
operation. Otherwise the flash couldn't send any data, there would
be two drivers for one signal. So being in hiZ state should be the 
default
and shouldn't depend on any connected flash.

You've mentioned the micron flash which needs a '1' on its hold/reset
pin. I would have expected a fixup for this flash, not for the flash 
which
behaves normal.

-michael
