Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021258D974
	for <lists+linux-spi@lfdr.de>; Tue,  9 Aug 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243369AbiHINhW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Aug 2022 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243385AbiHINhQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Aug 2022 09:37:16 -0400
X-Greylist: delayed 7559 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 06:36:54 PDT
Received: from blackstone.apzort.in (unknown [202.142.85.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1ACD208
        for <linux-spi@vger.kernel.org>; Tue,  9 Aug 2022 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=anurav.com;
        s=default; h=Content-Type:MIME-Version:Message-ID:Reply-To:From:Date:Subject:
        To:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YVUHs7UWdP4x/mxKiJOQPqdBXveF2XkswSL24fudVuE=; b=UFkOdHZJMQb1ZWSMF2/+S0nmbX
        5tXtmmOVMy+MwZXa8u8aXCmH76vBWaUVCCGgTO9a6xrWcarW3bRmVzrKh4Sj0WdnMCxg1DvnBOvBQ
        vcWDV5KO8PwkLks4atzlFmFvCr4Ik49MCWD1aYKsPQGJxQTxzHzcHtJ7CQbIPC9xutuA82x6Qk1bV
        Gc5efSZG1y0gSh94B4leQwM3LD/rjtBxaoUDxxMEPElSQt/LFDUHD9FvYXmhdZStPnKQprbHWXTlb
        ZmrmScGTdTyDRwr+7F8Na2BJJ0Ao7Kp1OWWYksbGksMPLKHayQ6prd0rwu2a75vy+FKW76jY7t5C9
        HY5lFa5w==;
Received: from apzort by blackstone.apzort.in with local (Exim 4.94.2)
        (envelope-from <apzort@blackstone.apzort.in>)
        id 1oLNRV-00FFWY-8b
        for linux-spi@vger.kernel.org; Tue, 09 Aug 2022 17:00:37 +0530
To:     linux-spi@vger.kernel.org
Subject: =?us-ascii?Q?Anurav_Dhwaj__"EINE_FINANZKRISE_KANN_SIE_SEHR_R?=  =?us-ascii?Q?EICH_MACHEN!"?=
X-PHP-Script: www.anurav.com/index.php for 191.101.31.24
X-PHP-Originating-Script: 1000:PHPMailer.php
Date:   Tue, 9 Aug 2022 11:30:37 +0000
From:   Anurav Dhwaj <mail@anurav.com>
Reply-To: mail@anurav.com
Message-ID: <Dwju0Cuu2DOk8uTPm1Jxo6U1n9Y6gwLkpoSVLLCFQaA@www.anurav.com>
X-Mailer: PHPMailer 6.6.0 (https://github.com/PHPMailer/PHPMailer)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blackstone.apzort.in
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [1000 989] / [47 12]
X-AntiAbuse: Sender Address Domain - blackstone.apzort.in
X-Get-Message-Sender-Via: blackstone.apzort.in: authenticated_id: apzort/from_h
X-Authenticated-Sender: blackstone.apzort.in: mail@anurav.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Spam-Status: Yes, score=7.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PHP_SCRIPT,
        RCVD_IN_PBL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [202.142.85.54 listed in zen.spamhaus.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.8 RDNS_NONE Delivered to internal network by a host with no rDNS
        *  2.3 PHP_SCRIPT Sent by PHP script
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Message Body:
DIE WELTFINANZKRISE KANN SIE SEHR REICH MACHEN! https://telegra.ph/Deutschland-hat-eine-neue-Einnahmequelle-von-548617-Euro-pro-Woche-08-07

-- 
This e-mail was sent from a contact form on Anurav Dhwaj  (https://www.anurav.com)

