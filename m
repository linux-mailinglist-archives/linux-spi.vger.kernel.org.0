Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A04FDF83
	for <lists+linux-spi@lfdr.de>; Tue, 12 Apr 2022 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353590AbiDLMVC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 12 Apr 2022 08:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355096AbiDLMSn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 12 Apr 2022 08:18:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCB3ED38;
        Tue, 12 Apr 2022 04:20:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5002A619F1;
        Tue, 12 Apr 2022 11:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D74C385A5;
        Tue, 12 Apr 2022 11:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649762402;
        bh=yLeKbNWYA2L/zMPRL5zlItCvNfHvvxoYrOJc3j6Phwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDpBg+JrUEtSuWLQweNE9fw3i9YJS/+h2m19RIP8WgFGKDPQDkvaPzrjh09TGhPAJ
         27Qm5wrlnW60NWhmEJQQpb241jWqg5KjdsmdLrCoFuAYmgQ98RGWfOZhDyfnCIJM2O
         AjdO2YgNEp2bS6We74m4Swduuv5YJ4Aw5v6pSJkP+pSO4tOhbLOYAEic8rxSww1k2Y
         Jh1yGftSz7bJbMeLtxEnXCfAQMs4AdF9tPzxCK2I31iM9WBxIPqQzataLIXBOE91/t
         qfruqL5vHsVN0E8omNHVRheOrw7i0tMKTOYfluHjZkOfut6InrauzUj3l5ot53sF/d
         drJDlR1QvDV7A==
Date:   Tue, 12 Apr 2022 16:49:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] spi: spi-rspi: Remove setting
 {src,dst}_{addr,addr_width} based on DMA direction
Message-ID: <YlVgXuhyNhXuRQmg@matsya>
References: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411173115.6619-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 11-04-22, 18:31, Biju Das wrote:
> The direction field in the DMA config is deprecated. The rspi driver
> sets {src,dst}_{addr,addr_width} based on the DMA direction and
> it results in dmaengine_slave_config() failure as RZ DMAC driver
> validates {src,dst}_addr_width values independent of DMA direction.
> 
> This patch fixes the issue by passing both {src,dst}_{addr,addr_width}
> values independent of DMA direction.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
