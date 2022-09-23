Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DD35E7999
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 13:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIWLbm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIWLbl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 07:31:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635AE12AEC1;
        Fri, 23 Sep 2022 04:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D4CDCE2447;
        Fri, 23 Sep 2022 11:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1075C433C1;
        Fri, 23 Sep 2022 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663932696;
        bh=mOjG/FUbEHdyYgDCtJqCqPGSlcHluWPszXW3Snph77k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=exGCjyyBrb6gSt2WMApct3hSmgOysoSFM85EvnIVjRBiOE4ZARq+1YxnrqsClxwWs
         EJv94BoyJk0wC689f9qDASsS7tX+uuwYaJ3U/AbDOZM6DOxKeIBE5xldayBMe8TDYR
         GdckP4SWTeLHUu5K4rc8ojDYG7KeqkBvFZzgRE46rGbsB3BRF1EO3QNnm0WpEEqmaM
         gL1y+7OtjCSQEb23KkAbHFC51SVnqVdZv5tda31YXxoDm4lQ42REDG0zXhXtgsF852
         r0xBwwTq2rSml78KjQL6NS+JdpxcbJVrPkE3RwYH4k9g7Hatur74EarCS15FVXPRpg
         I2RAQwQt6oSWw==
Message-ID: <0a173b89-b5ee-ad54-274a-4464a3d699c5@kernel.org>
Date:   Fri, 23 Sep 2022 13:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: airoha: Add documentation for
 Airoha SPI controller
Content-Language: en-US
To:     Bert Vermeulen <bert@biot.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
References: <20220922100410.1101874-1-bert@biot.com>
 <20220922100410.1101874-2-bert@biot.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220922100410.1101874-2-bert@biot.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/09/2022 12:04, Bert Vermeulen wrote:
> Create documentation for accessing the Airoha EN7523 SPI controller.
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---

Use scripts/get_maintainers.pl to CC all maintainers and relevant
mailing lists.

Pushing bindings without CC-ing maintainers is not the way...

Best regards,
Krzysztof

