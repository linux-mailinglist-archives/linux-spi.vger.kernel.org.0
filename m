Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1325E7A44
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 14:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiIWMMW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiIWMKT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 08:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAACB138F29;
        Fri, 23 Sep 2022 05:07:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4890B61200;
        Fri, 23 Sep 2022 12:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CCCC433C1;
        Fri, 23 Sep 2022 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663934848;
        bh=tqkLvQ4raapJJcXtSVd8WeQKMRd0RIkTwD8ZkUtIsuM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ltxipscCNyJEprtqz/z4ELwkcFNY9URPLQAcUh0pALERdk90JXeVXrZqSwXThdpvG
         Cf9R95UZvenY45j84UrhVrVn1SRcL6J/rOz4x5+EycemgHIRhqMIWfCMC5+r2cTRSc
         etI9MZYvI8lXIFbw+RXQhBEBCblqL7eA/MVVnUiJ6JbtHCLEK79i2eyQav8VSDvXxL
         2Jou44v2ZjEWZPns9WmtnR2EmZRkiF7sm4l2wM3skLWEtyNr5BjUXp+tnyR8xq2OIr
         bjkrbCLS3OX32LhxPSjx2ncnGW476KMse7qo8mEEL0G8tHwtG4BtcmzKlWU33RshaJ
         +ukRF6dKF8sjA==
Message-ID: <eab77948-afca-ed15-ca9a-b415220e1a18@kernel.org>
Date:   Fri, 23 Sep 2022 14:07:24 +0200
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
 <0a173b89-b5ee-ad54-274a-4464a3d699c5@kernel.org>
 <2cf91190-4c20-6c3a-2916-81d0d6c72aea@biot.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <2cf91190-4c20-6c3a-2916-81d0d6c72aea@biot.com>
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

On 23/09/2022 13:55, Bert Vermeulen wrote:
> On 9/23/22 13:31, Krzysztof Kozlowski wrote:
>> On 22/09/2022 12:04, Bert Vermeulen wrote:
>>> Create documentation for accessing the Airoha EN7523 SPI controller.
>>>
>>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>>> ---
>>
>> Use scripts/get_maintainers.pl to CC all maintainers and relevant
>> mailing lists.
>>
>> Pushing bindings without CC-ing maintainers is not the way...
> 
> Oh sorry! I'll Cc you on V2 of the patchset.
> 

It's not the point to cc me. The point is to Cc all necessary
maintainers. We have script for this, so you don't have to figure out
people addresses...

Best regards,
Krzysztof

