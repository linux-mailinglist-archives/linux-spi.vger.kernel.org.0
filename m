Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A013E5105E5
	for <lists+linux-spi@lfdr.de>; Tue, 26 Apr 2022 19:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiDZRu5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Apr 2022 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353594AbiDZRty (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Apr 2022 13:49:54 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Apr 2022 10:46:45 PDT
Received: from smtp115.iad3a.emailsrvr.com (smtp115.iad3a.emailsrvr.com [173.203.187.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943B91B2
        for <linux-spi@vger.kernel.org>; Tue, 26 Apr 2022 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1650994644;
        bh=ifCaPbys77tg9vGFnjipCOWbj5/jUegLBzcvdn5NroM=;
        h=Date:To:From:Subject:From;
        b=kXDND7N5KTWp/AIEAG3TQcgzUsxLC+FO9DtHhE6vLegAhTcTemRbrRJYiyNxssK6w
         hayj1gtO3SXGdy/veecXNR+VdYfHHY22Qx/u/925a37iwatDmScHDAwO1SRrt8QrQl
         YHIsv5Vhd2GDyGLJXcCuM/uULsNTyiTHeAa50MGI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id D520423B5C;
        Tue, 26 Apr 2022 13:37:23 -0400 (EDT)
Message-ID: <75feeadb-fdb0-4df8-aecd-c8edea029eb6@mev.co.uk>
Date:   Tue, 26 Apr 2022 18:37:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-GB
To:     linux-spi <linux-spi@vger.kernel.org>
Cc:     Dinh Nguyen <dinguyen@kernel.org>
From:   Ian Abbott <abbotti@mev.co.uk>
Subject: [Q] Should direct access mode be enabled for intel,socfpga-qspi?
Organization: MEV Ltd.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 19c889a1-9ca1-4d5c-960f-0753e26c51f2-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi linux-spi folks,

Upstream commit 98d948eb8331 ("spi: cadence-quadspi: fix write 
completion support") introduced the "intel,socfpga-qspi" compatible 
string and the new CQSPI_NO_SUPPORT_WR_COMPLETION quirk.

Changing the device tree node's "compatible" string from "cdns,qspi-nor" 
to "intel,socfpga-qspi" sets CQSPI_NO_SUPPORT_WR_COMPLETION but no 
longer sets CQSPI_DISABLE_DAC_MODE.  I'm guessing that was unintentional 
and that quirks should have both bits set.

"socfpga.dtsi" sets the size of the AHB resource to 0x1000, so direct 
mode would only be used for the initial 4 KiB. "socfpga-arria10" and 
"socfpga-stratix10.dtsi" set the size of the AHB resource to 0x100000, 
so direct mode would be used for the initial 1 MiB (usually the whole 
flash device).

Can anyone confirm whether DAC mode should be used or not on socfpga?

Thanks,
Ian

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
