Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D833F5AFC
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhHXJ04 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:26:56 -0400
Received: from mail-vi1eur05on2112.outbound.protection.outlook.com ([40.107.21.112]:52705
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233910AbhHXJ0y (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 05:26:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m078NwnQUDBj+72x7+DQDSYPYJa2QrfwejFJjgxTZuY5nKX08PAS3G9aF525G6ldeJgm/xjV/i7/dJQE8Z/j0IZGPQJOgZLaE2D3jMVu0ZayrEECoPqLI/ROGfTksBrkhvlFuP7y9ac/m4zyXSdrVuKt9+SXhvwobQ4n4NRqtCKCsOB9m/soBH/qSVp7JXrYtHkjF8byjGUk6IKYfUiaDGpxDrRhHlqNp4NFFM72NDbdv3UtGQ0fRAO/ZhGcNBIRg0aVjtS+ags8TQTvYN+iON5oitSZQXj3JuOUgVwjDPY5t8tumv5wF63dtWXmxegzVm9sPvRm9QgPadB8xqCmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIcH8kCXn6OOuFVQ4ouNXgeDtmFoon5Bp9AMDcARwoA=;
 b=LaUrIxTV7UJq38Ule36P3q9gcceqJOyoCn8vaViZ+Icg3drU402p3yBbXzr6WWYnpCwcFTyCvTxaBO44XTaoM3EOHF91BUv1EYxRFF/72ZoLzN62wAuBFMjdHVTzp0tsjE4sH3VkorNJxY1zKvlV+MzHVpEs3cPJyi33YxVFZNiQWNKP1UG3x4evrnfDq5124DyyW2m6gLK/O8zFc/buma7xL0rU3OxqqK7/xRYj74u6bbfp/UiUXcTNin2jPEHBWp+yhKEtU9hKnKX9Hngku9rBvTHrngffKxcj1r5oLtikRBg4xG3UbMM7Vf3WxSC9tSoY4xwbO+pWZQgIjfZDSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIcH8kCXn6OOuFVQ4ouNXgeDtmFoon5Bp9AMDcARwoA=;
 b=nC2mmleWDMKKN2E3gau6qeXiw5nb0UIxd1te8o26o02oloQrAs6f1ZKN1e03mGhbKJ/U0rYUx35pt9GC1lafeF0Wo9ObuYc5CLOyi6qcVguNwXiBSWkgm9mFmJ+QNjtEVBqJrjGlEpQTI9bbLxkfRn4sjv+H9G9mvXOU2iiews0=
Authentication-Results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=nokia.com;
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19) by VI1PR07MB4047.eurprd07.prod.outlook.com
 (2603:10a6:803:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.11; Tue, 24 Aug
 2021 09:26:04 +0000
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::25ec:1b41:d4d5:93fa]) by VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::25ec:1b41:d4d5:93fa%11]) with mapi id 15.20.4457.017; Tue, 24 Aug
 2021 09:26:03 +0000
To:     "Glavinic-Pecotic, Matija (EXT-Other - DE/Ulm)" 
        <matija.glavinic-pecotic.ext@nokia.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH] spi: davinci: invoke chipselect callback
Message-ID: <735fb7b0-82aa-5b9b-85e4-53f0c348cc0e@nokia.com>
Date:   Tue, 24 Aug 2021 11:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:610:76::17) To VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19)
MIME-Version: 1.0
Received: from [172.30.9.6] (131.228.32.166) by CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 09:26:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331e8db6-02cf-4ed7-144a-08d966e13199
X-MS-TrafficTypeDiagnostic: VI1PR07MB4047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB4047EFF09960AEBE4FCC1AFFFFC59@VI1PR07MB4047.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TA0ZVzSVKo7hJXPC5GFmUTj7NbZjs29JSSlR9ljDjhTISoXDrvSlyJJMQNwiopIfN0TzgvXRNiPQ9ZT0qztZy0vvcj+hxzAFizAaVzTEhn1EuSfo4S3tTBneRyfxB4gxX1zb8AgnCSHINOYgv+BT8vmvzZ5SdD89rmIXONtBa6hAaEMijZe8SD5SAkX0PheWRsXfTiSBhe1ndz7L57vBuyNaWX0C/ZmS8nFx5D18Zj1qE4pzAXMZpUe+6ptO9tm9jq8HoplaBILVbpOD2oox0KezbWKvK2g/Gl/yb6+E46fnsSV+6K8869+ki/mlUAgpJ5l+P8SNu2M9d/BBu8r8CtUDzxsdAFkTCmoX7bIGXKA15O2YCitFa7wNBXVimi8UtU7kZNTKFG7ZuEDkpT4X5ZCHslwXDdVDtw+ic2uD+oj30izkXpaegAXfvqf3UpMjRjb3ldVIWIsdTzfVw9NX0Te27LgJTRb08Ph4CUoSvIaYKgqOxRanL/cXEJ4fSqZl/nnv9C0Q3Kq23WUcSBK7Nb3tnDQSzfSIO/f9AXyGjddN8AE6ZRw8UJigt8I7qnfOVcS3Nf/R/2dh8vJyENbha7P/VjAZRSfkw4lUlI3t9MxWdMh0R3wZ44Q3EzlTiDQsVjPZQFaIkZtfNsI0wq+UFoM7B9RZTr5wXYs/cqUWl45yis6+Y55F+C8tVupz1LApg4BEKgqmMUSil9rDWNfHA+TffizEcxdRu7BZdoa0vy5G72sfS41XbIqabN04LfKRESKbdcV3MV8cnrvyYmN8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0701MB3005.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6486002)(31686004)(16576012)(86362001)(66476007)(316002)(2616005)(107886003)(2906002)(8676002)(4326008)(31696002)(956004)(8936002)(6666004)(5660300002)(186003)(508600001)(26005)(38350700002)(52116002)(38100700002)(36756003)(66946007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZGRHhTKzBMU1FWMkRNc3VNK0R0eXBQeXY5empoYmNEK3JWRUpndFYzV241?=
 =?utf-8?B?SUNyK0dMOTN4Tm42ZjIzWGZlMHgxcS9Hanp1ck5OanpPZDFnVTZhZHhWMEU0?=
 =?utf-8?B?YVk1cEtQRk54bXN5ZExMVFpSK0NWbnBkazFueDRCTUh0TWlpTnNqUlBqQjRZ?=
 =?utf-8?B?ZEdwVGpVRDR1YlRIcGN5RVFncWZYL2lXb1JGOFBBSEFmdVF3dzRCb0RXaFoy?=
 =?utf-8?B?Y1FUdlAyd1JvSVBNbTZLYmg0OWFYUnIrakNYUncxVWIya2g5WHF1UFpScEFo?=
 =?utf-8?B?cnM0NXREMEhGd0xYdGNyRTJtL3NtVDBHd2ZBYi8vL1V4YWIrZ0tQbjVzZHVE?=
 =?utf-8?B?OUk5dlR0aGtzOGprK3pQNitkYXVQNkljaHVmd2M5K2VxZWlUWEVvb0pSbXFZ?=
 =?utf-8?B?YVF4YnNWN042MkxaMklMc2kwcjF3bVhRT05MQWpyTy9SU09uTWR2TDhqOGt5?=
 =?utf-8?B?U0drbEJIbXJ3ZFQ4Mi9KVnhlaW5JVFQ1cjQ1WlExcXcySWRUbytPakVPMW5V?=
 =?utf-8?B?SmxXbUZzU0pjTTRObUo5WVFocUViN3NaV0VzWGhnTlVUbjdDNFB0QWdNYmVh?=
 =?utf-8?B?SVE3Y2gybjkySTExazVNeU1nanFyeG1OdTQ0bjdUOWhnYWxmWnEyY2N0TDJk?=
 =?utf-8?B?NEJQQUc4RTkyREIxQ2JPd3M3ekR2QzhCYk9Vb3FFYSs5a1NOMlZ6ZnVkQzVo?=
 =?utf-8?B?Q1B1YkhzU09uSTliTS9VcDZySUVZcDlGZzlPYnhFb3Q0QlZDQlBTRFY4Njgz?=
 =?utf-8?B?OXNJYm9FMDVpc1I1ZjVZZnBuZ0doWW91MEx5NFF0azRJTG92NWdBemhuZVJz?=
 =?utf-8?B?VXBObjBwb1hYMXN0cmdxanJLU0JpbE5sdUhST2tKZDVmS0wwL0dvS0RFb0J5?=
 =?utf-8?B?ZW1oY0pIdXNvOERiajRNNjJ5UVFMcXBiZk5XMzZVUVoxU25TajZHUXg4YjlR?=
 =?utf-8?B?Y29XY01oMFNQL0h2MFdzTUtEQmNoZkFmMk1PTzF1Rm5xbU9lMVMweTk2dHBX?=
 =?utf-8?B?Ymd1bVp0RmgzLzg2bVF2eUR4Tyt3ZmM4NDdqMCtqcUVYTWp6L2ZvVDJNb3o1?=
 =?utf-8?B?bzNNbkJEREt3RWp4SzJwanZzVkhKSTVNVDdiUktQSXZzMnFub0tBQWtnMTVs?=
 =?utf-8?B?bWNHaU5zZExXbTlqaEl6UVIwUFBnOExzNDg3YXQrNmFaSUFGcFRuOHByNkoz?=
 =?utf-8?B?eVpYYWl4NkNYVFE4OWVqVk54TVpOSlYva0xzRnY5K1cvajA4YVl3MzFpcTVy?=
 =?utf-8?B?WnFOVG9lRHhwb0VTdFZWb1lUOUZFTWN4U3R5cVBwQ0toaVBYcVdYVlJXcXRM?=
 =?utf-8?B?ZlZSYnAxV0FVVjdEdEtoUXd3TEx5N0xNQVB0VXVtQzBJTFJEVmtkcWF4UHpv?=
 =?utf-8?B?NUx4WDRXNGxrUTJoU3ZZQlJGR3VWQW84WVNHOFhSQ0EyazQxNVZXRGh4V0dO?=
 =?utf-8?B?RTRLQ2l2aE84YWZDb0MrMFRUMUkvU1FJSnZ1ZjhXRXdLUy9QKzdXTFFGWTZP?=
 =?utf-8?B?dy9zMGRUTld1L0VBVnQxVFdyemRod0lEM213cVVueEJFcFo3MjRDeGJFQmI2?=
 =?utf-8?B?NWZjT1RtekNKOXNtQ2JLaWJ4QmVTbHBjb1drWmRGdlNZMFRGVTdJNTNxTWph?=
 =?utf-8?B?VHdiNnlDZ2NGNDRvdDFRdVZlbjdCK3pQK3dwU0daKytNWnEzSzFsN2tDa09Q?=
 =?utf-8?B?Wi9ZQW1VcHdaRWdIeUJWK09COVd4Tm5ZR3EwekJJcVQwcmR0d0ZJbWVmOVht?=
 =?utf-8?Q?HqbO8t3OlM7jO7AZCyvEidk4Ha0F1BT22STM0D8?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331e8db6-02cf-4ed7-144a-08d966e13199
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB3005.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 09:26:03.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+/xL6sZ62pPjQ8M9scK/N46b5hsrvX2+tsuwPLd46eGH+Xb+QcHGrEPZlwVf+E9ze4V7ygedZX+xjM4fm0/UHUIFlmXVz+ylYR9YAgqOZECBbo3RxZ8UVulCWfjtipI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4047
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Davinci needs to configure chipselect on transfer.

Fixes: 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")

Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
 drivers/spi/spi-davinci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index f71c497393a6..c3974d996cb8 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -213,12 +213,6 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	 * line for the controller
 	 */
 	if (spi->cs_gpiod) {
-		/*
-		 * FIXME: is this code ever executed? This host does not
-		 * set SPI_MASTER_GPIO_SS so this chipselect callback should
-		 * not get called from the SPI core when we are using
-		 * GPIOs for chip select.
-		 */
 		if (value == BITBANG_CS_ACTIVE)
 			gpiod_set_value(spi->cs_gpiod, 1);
 		else
@@ -950,7 +944,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = pdata->num_chipselect;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
-	master->flags = SPI_MASTER_MUST_RX;
+	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_GPIO_SS;
 	master->setup = davinci_spi_setup;
 	master->cleanup = davinci_spi_cleanup;
 	master->can_dma = davinci_spi_can_dma;
-- 
2.26.0
