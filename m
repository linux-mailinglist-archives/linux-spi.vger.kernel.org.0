Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075885E7A09
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 13:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiIWL4A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 07:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbiIWL4A (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 07:56:00 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE5311E0CC
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 04:55:57 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obhHe-00C0Vj-LL
        for linux-spi@vger.kernel.org; Fri, 23 Sep 2022 13:55:54 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from [2a01:4f8:10a:f402::1:2]
        by yawp.biot.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1obhHS-00C0VR-Kg; Fri, 23 Sep 2022 13:55:42 +0200
Message-ID: <2cf91190-4c20-6c3a-2916-81d0d6c72aea@biot.com>
Date:   Fri, 23 Sep 2022 13:55:42 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] dt-bindings: arm: airoha: Add documentation for
 Airoha SPI controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>
References: <20220922100410.1101874-1-bert@biot.com>
 <20220922100410.1101874-2-bert@biot.com>
 <0a173b89-b5ee-ad54-274a-4464a3d699c5@kernel.org>
From:   Bert Vermeulen <bert@biot.com>
In-Reply-To: <0a173b89-b5ee-ad54-274a-4464a3d699c5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/23/22 13:31, Krzysztof Kozlowski wrote:
> On 22/09/2022 12:04, Bert Vermeulen wrote:
>> Create documentation for accessing the Airoha EN7523 SPI controller.
>> 
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> ---
> 
> Use scripts/get_maintainers.pl to CC all maintainers and relevant
> mailing lists.
> 
> Pushing bindings without CC-ing maintainers is not the way...

Oh sorry! I'll Cc you on V2 of the patchset.


-- 
Bert Vermeulen
bert@biot.com
